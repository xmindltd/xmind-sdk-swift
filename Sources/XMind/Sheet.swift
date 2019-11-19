//
//  Sheet.swift
//  XMindSDK
//
//  Created by h on 2019/11/8.
//
//  Copyright © 2019 XMind.
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

public class Sheet: Codable {
    public let id: String
    
    public let `class`: String
    
    public let title: String
    
    public let rootTopic: Topic
    
    public let topicPositioning: String
    
    public private(set) var relationships: [Relationship]?
    
    public let theme: Theme
    
    public init(title: String, rootTopic: Topic) {
        self.id = UUID().uuidString
        self.class = "sheet"
        self.title = title
        self.rootTopic = rootTopic
        self.topicPositioning = "fixed"
        self.relationships = nil
        self.theme = Theme.snowbrush
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case `class`
        case title
        case rootTopic
        case topicPositioning
        case relationships
        case theme
    }

}

extension Sheet: Equatable {
    public static func == (lhs: Sheet, rhs: Sheet) -> Bool {
        return lhs === rhs
    }
}
