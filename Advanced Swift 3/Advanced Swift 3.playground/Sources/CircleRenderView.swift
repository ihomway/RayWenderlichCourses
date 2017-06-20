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

public struct Circle {

  // MARK: - Properties
  public var position: CGPoint
  public var radius: CGFloat
  public var color: UIColor

  // MARK: - Initializer
  public init(position: CGPoint, radius: CGFloat, color: UIColor) {
    self.position = position
    self.radius = radius
    self.color = color
  }
}

public class CircleRenderView: UIView {

  // MARK: - Properties
  public var circles: [Circle] = [] {
    didSet {
      setNeedsDisplay()
    }
  }

  // MARK: - Custom drawing
  public override func draw(_ rect: CGRect) {
    guard let context = UIGraphicsGetCurrentContext() else {
      return
    }

    context.setFillColor(UIColor.black.cgColor)
    context.fill(bounds)

    for circle in circles {
      let origin = circle.position-CGPoint(x: circle.radius, y: circle.radius)
      let size = CGSize(width:circle.radius*2, height: circle.radius*2)
      let r = CGRect(origin: origin, size: size)
      context.setFillColor(circle.color.cgColor)
      context.addEllipse(in: r)
      context.fillPath()
    }
  }
}
