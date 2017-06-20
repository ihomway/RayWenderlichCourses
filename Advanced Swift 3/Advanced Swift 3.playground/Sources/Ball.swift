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

public struct Ball {

  public init(position: CGPoint, velocity: CGPoint, color: UIColor = .white, radius: CGFloat) {
    self.position = position
    self.velocity = velocity
    self.color = color
    self.radius = radius
  }

  public func overlaps(_ other: Ball) -> Bool {
    let distance = radius + other.radius
    return (position - other.position).lengthSquared < distance * distance
  }

  // Simulate a collision between this ball and another.
  mutating func collide(with other: inout Ball) {
    let p12 = position - other.position
    let v12 = velocity - other.velocity
    let p21 = other.position - position
    let v21 = other.velocity - velocity
    velocity -= (v12).dot(p12) / p12.lengthSquared * p12
    other.velocity -= (v21).dot(p21) / p21.lengthSquared * p21

    if velocity.lengthSquared > CGFloat.ulpOfOne {
      repeat {
        position += velocity
        other.position += other.velocity
      } while (overlaps(other))
    }
  }

  public var position: CGPoint
  public var radius: CGFloat
  public var velocity: CGPoint
  public var color: UIColor
}

