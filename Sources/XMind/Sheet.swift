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

/// Sheet represents a mind map panel
/// which contains a root topic.
public class Sheet: Codable {
    
    
    /// The unique ID of this sheet.
    public let id: String
    
    /// The class of this sheet.
    public let `class`: String
    
    /// Title of this sheet which represents the name of this panel.
    public var title: String
    
    /// The root topic of this panel.
    /// A sheet only can contains a root topic,
    public let rootTopic: Topic
    
    /// The topic positioning function.
    public let topicPositioning: String
    
    /// The relationships of this panel.
    public let relationships: [Relationship]?
    
    /// Theme of this panel.
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

}

extension Sheet: Equatable {
    public static func == (lhs: Sheet, rhs: Sheet) -> Bool {
        return lhs === rhs
    }
}
