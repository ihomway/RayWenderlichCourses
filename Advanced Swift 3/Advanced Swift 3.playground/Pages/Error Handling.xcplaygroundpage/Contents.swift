//: [Previous](@previous)

import Foundation

// MARK: CustomErrors

//do {
//	let file = FileHandle(forReadingAtPath: "sdf")
//	print("Returning Handle:", file as Any)
//}
//
//enum PlainError: Int, Error {
//	case boom = 100
//	case bam
//}
//
//enum FancyError: Error {
//	case kazam(String)
//}
//
//do {
//	throw PlainError.bam
//}
//catch {
//	print("Default Match", error)
//}
//
//do {
//	throw PlainError.boom
//}
//catch (let error as PlainError) {
//	print("Basic!", error)
//}
//catch FancyError.kazam(let message) {
//	print("Fancy!", message)
//}
//catch {
//	print(error)
//}
//
//do {
//	throw FancyError.kazam("With a message!")
//}
//catch (let error as PlainError) {
//	print("Basic!", error)
//}
//catch FancyError.kazam(let message) {
//	print("Fancy!", message)
//}
//catch {
//	print(error)
//}

// MARK: NSError
//enum PlainError: Int, Error {
//	case boom = 100
//	case bam
//}
//
//enum FancyError: Error {
//	case kazam(String)
//}
//
//// Plain Error converted to NSError
//do {
//	throw PlainError.bam
//}
//catch (let error as NSError) {
//	print("NSError:", error.code, error.domain, error.userInfo)
//}
//
//// Fancy Error converted to NSError
//do {
//	throw FancyError.kazam("Hello")
//}
//catch (let error as NSError) {
//	print("NSError:", error.code, error.domain, error.userInfo)
//}
//
//do {
//	let file = try FileHandle(forReadingFrom: URL(fileURLWithPath: "sdf"))
//}
//catch (let error as NSError) {
//	print("NSError:", error.code, error.domain, error.userInfo)
//	print(error.localizedDescription)
//}

// MARK: Result
//enum Result<T> {
//	case success(T)
//	case failure(Error)
//}
//
//enum MathError: Error {
//	case divisionByZero
//}
//
//func compute(a: Int, b: Int) -> Result<Int> {
//	guard b != 0 else {
//		return Result.failure(MathError.divisionByZero)
//	}
//	
//	return Result.success(a / b)
//}
//
//compute(a: 10, b: 0)
//compute(a: 10, b: 2)

// MARK: File
// A simple file abstraction built on top of C standard io.
// See http://www.cplusplus.com/reference/cstdio/

enum FileError: Error {
	case missingRootDirectory
	case open(String)
	case notOpen
	case get(ferror: Int32)
	case stringDecode(Data)
	case position(errno: Int32)
	case eof
	case unableToWrite
	case seek
	case size
}

// A file can be opened and closed.
class File {
	enum Mode: String {
		case reading = "r",
		writing = "w",
		appending = "a",
		readingAndWriting = "r+",
		writingAndReading = "w+"
	}
	
	// The File and mode
	let filename: String
	let mode: Mode
	
	// underlying FILE
	fileprivate var file: UnsafeMutablePointer<FILE>?
	
	// Opens the file on initialization and throws if it cannot.
	init(filename: String, mode: Mode) throws {
		self.filename = filename
		self.mode = mode
		
		try filename.withCString { f in
			try mode.rawValue.withCString { m in
				file = fopen(f, m)
				if file == nil {
					throw FileError.open(filename)
				}
			}
		}
	}
	
	// Close the file and set it to nil
	func close() {
		guard let file = file else {
			return
		}
		fclose(file)
		self.file = nil
	}
	
	deinit {
		close()
	}
}

// Positioning API
extension File {
	// A simple types that encapsulates position
	struct Position {
		var offset: Int64
	}
	
	// Get the position of the file
	func position() throws -> Position {
		guard let file = file else {
			throw FileError.notOpen
		}
		var pos: fpos_t = 0
		if fgetpos(file, &pos) != 0 {
			throw FileError.position(errno: errno)
		}
		return Position(offset: pos)
	}
	
	// Set the position of the file.
	func seek(to position: Position) throws {
		guard let file = file else {
			throw FileError.notOpen
		}
		var pos: fpos_t =  position.offset
		try withUnsafePointer(to: &pos) { posPointer in
			if fsetpos(file, posPointer) != 0 {
				throw FileError.seek
			}
		}
	}
}

// A interface for getting and putting strings into a file.
extension File {
	
	// Put a string into the file at the current position
	@discardableResult
	func put(_ message: String) throws -> Int {
		guard let file = file else {
			throw FileError.notOpen
		}
		
		let written = message.withCString { bytes in
			Int(fputs(bytes, file))
		}
		if written != message.utf8.count {
			throw FileError.unableToWrite
		}
		return written
	}
	
	// Get a line from the file or maxLineLength, whichever comes first.
	func get(_ maxLineLength: Int = 4096) throws -> String {
		guard let file = file else {
			throw FileError.notOpen
		}
		let bytes = UnsafeMutablePointer<Int8>.allocate(capacity: maxLineLength)
		defer {
			bytes.deallocate(capacity: maxLineLength)
		}
		
		fgets(bytes, Int32(maxLineLength), file)
		
		let error = ferror(file)
		if error != 0 {
			throw FileError.get(ferror: error)
		}
		
		if feof(file) != 0 {
			clearerr(file)
			throw FileError.eof
		}
		
		var readCount = 0
		for byte in UnsafeBufferPointer(start: bytes, count: maxLineLength) {
			readCount += 1
			if byte == 0 {
				break
			}
		}
		
		var backoffCount: Int64 = 0
		var data = Data(bytesNoCopy: bytes, count: readCount, deallocator: .none)
		
		// To handle UTF8 boundaries properly attempt to decode the string.
		// if that fails, it is probably that you have not read in all of the
		// bytes that you need to. If possible back off by a byte and see
		// if the string can be decoded.
		//
		// This will handle most cases, but fails when a single character
		// exceeds the size of the original read buffer.
		
		while true {
			if let decoded = String(data: data, encoding: .utf8) {
				if backoffCount > 0 {
					let pos = try position()
					try seek(to: Position(offset: pos.offset-backoffCount+1))
				}
				return decoded
			}
			else {
				if data.count > 0 {
					data.count -= 1
					backoffCount += 1
				}
				if data.count > 0 {
					data.count = readCount
					throw FileError.stringDecode(data)
				}
			}
		}
	}
}

// Create an extension to treat a file like a sequence

extension File {
	struct LineReader: Sequence {
		
		var file: File
		var maxLineLength: Int
		
		init(file: File, maxLineLength: Int) {
			self.file = file
			self.maxLineLength = maxLineLength
		}
		
		func makeIterator() -> AnyIterator<String> {
			return AnyIterator {
				return try? self.file.get(self.maxLineLength)
			}
		}
	}
	
	func lines(maxLineLength: Int = 4096) -> LineReader {
		return LineReader(file: self, maxLineLength: maxLineLength)
	}
}

// FileSystem is an API that handles adds a root to the sandbox of your files.

struct FileSystem {
	var root = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first
	
	// Convenience singleton
	static var `default` = FileSystem()
	
	func open(filepath: String, for mode: File.Mode) throws -> File {
		guard let root = root else {
			throw FileError.missingRootDirectory
		}
		let filepathWithRoot = root + "/" + filepath
		return try File(filename: filepathWithRoot, mode: mode)
	}
}


////////////////////////////////////////////////////////////////////////




func test() {
	// Open a file and write to it
	do {
		let file = try FileSystem.default.open(filepath: "Hello.txt", for: .writing)
		for i in 1...20 {
			try file.put("Hello, World 🌎 \(i)\n")
		}
		file.close()
	}
	catch {
		print(error)
	}
	
	// Open the file and read it back.
	do {
		let file = try FileSystem.default.open(filepath: "Hello.txt", for: .readingAndWriting)
		for line in file.lines() {
			print(line, terminator: "")
		}
		
		print("Reading a second time... should fail quitely")
		for line in file.lines() {
			print(line, terminator: "")
		}
		
		print("shhhhh")
		print("Manually reading.. Expecting EOF failure")
		print(try file.get())
	}
	catch {
		print("failed: \(error)")
	}
}
test()

enum Result<T> {
	case success(T)
	case failure(Error)
}

enum NumberErrors: Error {
	case integerParseError(String)
}

func sumNumbers(filepath: String, complete: @escaping (Result<Int>)->Void) {
	DispatchQueue.global().async {
		do {
			let file = try FileSystem.default.open(filepath: filepath, for: .reading)
			var sum = 0
			
			for line in  file.lines() {
				let scanner = Scanner(string: line)
				var value = 0
				if !scanner.scanInt(&value) {
					complete(Result.failure(NumberErrors.integerParseError(line)))
					return
				}
				sum += value
			}
			complete(Result.success(sum))
		}
		catch {
			complete(Result.failure(error))
		}
	}
}

func testAsync() {
	do {
		let file = try! FileSystem.default.open(filepath: "Numbers.txt", for: .writing)
		for value in 1...10 {
			try! file.put("\(value)\n")
		}
	}
	
	sumNumbers(filepath: "Numbers.txt") { result in
		
		switch result {
		case .success(let value):
			print("Sum:", value)
		case .failure(let error):
			switch error {
			case FileError.open(let name):
				print("Could not open \(name)")
			case NumberErrors.integerParseError(let str):
				print("Could not parse \(str)")
			default:
				print("generic error")
			}
		}
	}
}

import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

//testAsync()

//: [Next](@next)
