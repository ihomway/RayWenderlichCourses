//: Specify indefinite execution to prevent the playground from killing background tasks when the 'main' thread has completed.

import PlaygroundSupport
import UIKit

PlaygroundPage.current.needsIndefiniteExecution = true

//:# Terminology

//:## Using a Global Queue

//TODO: get the .userInitialted global dispatch queue
let userQueue = DispatchQueue.global(qos: .userInitiated)
//TODO: get the .default global dispatch queue
let defaultQueue = DispatchQueue.global()
//TODO: get the main queue
let mainQueue = DispatchQueue.main

//:### Some simple tasks:

func task1() {
	print("Task1 started")
	// mask task1 take longer than task2
	sleep(1)
	print("Task1 finished")
}

func task2() {
	print("Task2 started")
	print("Task2 finished")
}

print("=== Starting userinitated global quque ===")
//TODO: Disptach tasks onto the userInitated queue

duration {
	userQueue.async {
		task1()
	}
	userQueue.async {
		task2()
	}
}

sleep(2)
//:## Using a Private Serial Queue
//:### The only global serial queue is DispatchQueue.main, but you can create a private serial queue. Note that .serial is the default attribute for a private dispatch queue:

// TODO: Create mySerialQueue
let mySerialQueue = DispatchQueue(label: "cc.ihomway.serial");

print("\n=== Starting mySerialQueue ===")

// TODO: Dispatch tasks onto mySerialQueue
duration {
	mySerialQueue.async {
		task1()
	}
	
	mySerialQueue.async {
		task2()
	}
}

sleep(2)

//: ## Creating a Private Concurrent Queue
//: To create a private __concurrent__ queue, specify the `.concurrent` attribute.
// TODO: Create workerQueue
let workerQueue = DispatchQueue(label: "cc.ihomway.worker", attributes: .concurrent)
print("\n=== Starting workerQueue ===")

// TODO: Dispatch tasks onto workerQueue
duration {
	workerQueue.async {
		task1()
	}
	
	workerQueue.async {
		task2()
	}
}


//: ## Dispatching Work _Synchronously_
//: You have to be very careful calling a queue’s `sync` method because the _current_ thread has to wait until the task finishes running on the other queue. **Never** call sync on the **main** queue because that will deadlock your app!
//:
//: But sync is very useful for avoiding race conditions — if the queue is a serial queue, and it’s the only way to access an object, sync behaves as a _mutual exclusion lock_, guaranteeing consistent values.
//:
//: We can create a simple race condition by changing `value` asynchronously on a private queue, while displaying `value` on the current thread:
var value = 42

func changeValue() {
	sleep(1)
	value = 0
}
//: Run `changeValue()` asynchronously, and display `value` on the current thread
// TODO
mySerialQueue.async {
	changeValue()
}
value

//: Now reset `value`, then run `changeValue()` __synchronously__, to block the current thread until the `changeValue` task has finished, thus removing the race condition:
// TODO
value = 42
mySerialQueue.sync {
	changeValue()
}
value

sleep(2)
//: ## Playground vs App
//: In an app, the UI runs on `DispatchQueue.main`, but playgrounds run on the default global queue.
//:
//: In our playgrounds, we won't be doing work on the main queue:
print("\nRunning on main queue")
// TODO: Run a simple task on the main queue
mainQueue.async {
	let a = 6
	print("main queue: a = \(a)")
}

print("Running on default queue")
// TODO: Run a similar task on the default queue
defaultQueue.async {
	let a = 42
	print("default queue: a = \(a)")
}

// Allow time for sleeping tasks to finish before letting the playground finish execution:
sleep(3)
PlaygroundPage.current.finishExecution()

//: [Next](@next)
