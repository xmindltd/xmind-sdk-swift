//
//  ElementsBuilder.swift
//  XMindSDK
//
//  Created by h on 2020/4/4.
//
//  Copyright © 2020 XMind.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

import Foundation

public struct Elements<Element>: Sequence {
    
    public func makeIterator() -> IndexingIterator<[Element]> {
        return elements.makeIterator()
    }
    
    private var elements: [Element]
    
    internal var first: Element? {
        elements.first
    }
    
    internal init(_ elements: [Elements<Element>]) {
        self.elements = elements.flatMap { $0.elements }
    }
    
    internal init(_ element: Element) {
        elements = [element]
    }
    
    internal init() {
        elements = []
    }
    
}

@_functionBuilder
public struct ElementsBuilder<Element> {
    
    public static func buildBlock() -> Elements<Element> {
        return Elements<Element>()
    }
    
    public static func buildBlock(_ elements: Elements<Element>) -> Elements<Element> {
        return elements
    }
    
    public static func buildBlock(_ elements: Elements<Element>...) -> Elements<Element> {
        return Elements<Element>(elements)
    }
    
    public static func buildIf(_ elements: Elements<Element>?) -> Elements<Element> {
        if let elements = elements {
            return buildBlock(elements)
        } else {
            return buildBlock()
        }
    }
    
    public static func buildEither(first: Elements<Element>) -> Elements<Element> {
        return first
    }
    
    public static func buildEither(second: Elements<Element>) -> Elements<Element> {
        return second
    }
}
