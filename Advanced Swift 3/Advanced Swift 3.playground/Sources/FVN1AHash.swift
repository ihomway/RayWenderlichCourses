// Copyright (c) 2017 Razeware LLC
// See Copyright Notice page for details about the license.

import Foundation

// Fowler–Noll–Vo hash function
public struct FVN1AHash {
  private var hash: UInt64 = 0xcbf29ce484222325
  private let prime: UInt64 = 0x100000001b3

  // the compiler generated init() is internal
  public init() {}

  // Add more into the hash algorithm
  public mutating func consume<S: Sequence>(bytes: S) where S.Iterator.Element == UInt8 {
    for byte in bytes {
      hash = (hash ^ UInt64(byte)) &* prime
    }
  }

  // Finalize the hash value.  In this case a trivial copy to an Int.
  public var finalValue: Int {
    return Int(truncatingBitPattern: hash)
  }
}
