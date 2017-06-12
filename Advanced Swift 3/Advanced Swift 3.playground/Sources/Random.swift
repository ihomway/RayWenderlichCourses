/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import UIKit

public extension FloatingPoint {
  static func unitRandom() -> Self {
    return Self(arc4random())/(Self(UInt32.max)+Self(1))
  }
  static func closedUnitRandom() -> Self {
    return Self(arc4random())/Self(UInt32.max)
  }
}

// Closed ranges want to include the upperBound so they use Double.closedUnitRandom()
public extension ClosedRange where Bound: FloatingPoint {
  public var random: Bound {
    // generate a random value [0, 1]
    return lowerBound + (upperBound - lowerBound) * Bound.closedUnitRandom()
  }
}

// Half open ranges should not include the upperBound so they use Double.
public extension Range where Bound: FloatingPoint {
  public var random: Bound {
    // generate a radom value [0, 1)
    return lowerBound + (upperBound - lowerBound) * Bound.unitRandom()
  }
}

public extension Int {
  public var randomUniform: Int {
    return Int(arc4random_uniform(UInt32(self)))
  }
}

public extension RandomAccessCollection {
  var random: Iterator.Element {
    precondition(!isEmpty)
    let count: Int = numericCast(self.count)
    let randomDistance: IndexDistance = numericCast(count.randomUniform)
    let index = self.index(startIndex, offsetBy: randomDistance)
    return self[index]
  }
}

public extension UIColor {
  static var random: UIColor {
    let r = CGFloat(arc4random())/CGFloat(UInt32.max)
    let g = CGFloat(arc4random())/CGFloat(UInt32.max)
    let b = CGFloat(arc4random())/CGFloat(UInt32.max)
    return UIColor(red: r, green: g, blue: b, alpha: 1)
  }
}
