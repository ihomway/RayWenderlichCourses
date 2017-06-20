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

public extension Collection {
  func pairs() -> AnySequence<(Iterator.Element, Iterator.Element)> {
    guard var index1 = index(startIndex, offsetBy: 0, limitedBy: endIndex),
      var index2 = index(index1, offsetBy: 1, limitedBy: endIndex)
      else {
        return AnySequence { EmptyIterator() }
    }
    return AnySequence {
      return AnyIterator {
        if index1 >= self.endIndex || index2 >= self.endIndex {
          return nil
        }
        defer {
          index2 = self.index(after: index2)
          if index2 >= self.endIndex {
            index1 = self.index(after: index1)
            index2 = self.index(after: index1)
          }
        }
        return (self[index1], self[index2])
      }
    }
  }
}
