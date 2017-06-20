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

import Foundation
import CoreGraphics

public extension CGPoint {
  static func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x+rhs.x, y: lhs.y+rhs.y)
  }

  static func *(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return CGPoint(x: lhs.x*rhs, y: lhs.y*rhs)
  }

  static func *(lhs: CGFloat, rhs: CGPoint) -> CGPoint {
    return rhs*lhs
  }

  static func /(lhs: CGPoint, rhs: CGFloat) -> CGPoint {
    return lhs * (1/rhs)
  }

  static prefix func -(input: CGPoint) -> CGPoint {
    return CGPoint(x: -input.x, y: -input.y)
  }

  static func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return lhs+(-rhs)
  }

  static func +=(lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs + rhs
  }

  static func -=(lhs: inout CGPoint, rhs: CGPoint) {
    lhs = lhs - rhs
  }

  static func *=(lhs: inout CGPoint, rhs: CGFloat) {
    lhs = lhs * rhs
  }

  static func /=(lhs: inout CGPoint, rhs: CGFloat) {
    lhs = lhs / rhs
  }

  var lengthSquared: CGFloat {
    return dot(self)
  }

  var length: CGFloat {
    return lengthSquared.squareRoot()
  }

  static func *(lhs: CGPoint, rhs: CGAffineTransform) -> CGPoint {
    return lhs.applying(rhs)
  }

  func dot(_ other: CGPoint) -> CGFloat {
    return x*other.x + y*other.y
  }
}
