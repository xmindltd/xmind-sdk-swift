//
//  Topic.swift
//  XMindSDK
//
//  Created by CY H on 2019/11/4.
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

public class Topic: Codable {
    
    public struct Children: Codable {
        public var attached: [Topic]?
        public var detached: [Topic]?
        
        init() {
            attached = []
            detached = []
        }
    }
    
    public let id: String
    
    public let `class`: String?
    
    public var title: String?
    
    public let structureClass: String?
    
    public let titleUnedited: Bool
    
    public private(set) var markers: [Marker]?
    
    public private(set) var children: Children?
    
    
    weak private(set) var superTopic: Topic? = nil
    
    public func addSubTopic(_ topic: Topic) {
        
        var _topic: Topic? = self
        
        while let t = _topic {
            if t == topic {
                print("XMindSDK: Can't add an ancestor as a sub topic.")
                return
            }
            _topic = t.superTopic
        }
        
        
        if children == nil {
            children = Children()
        }
        
        if children?.attached == nil {
            children?.attached = []
        }
        
        if children!.attached!.contains(where: { $0 === topic }) {
            return
        }
        
        topic.removeFromSuperTopic()
        children!.attached!.append(topic)
        topic.superTopic = self
    }
    
    public func addSubTopic(_ title: String) -> Topic {
        let topic = Topic(title: title)
        addSubTopic(topic)
        return topic
    }
    
    public func removeSubTopic(_ topic: Topic) {
        
        guard let droped = children?.attached?.drop(while: { $0 === topic }) else { return }
        
        for topic in droped {
            topic.superTopic = nil
        }
    }
    
    public func removeFromSuperTopic() {
        superTopic?.removeSubTopic(self)
    }
    
    public init(title: String) {
        self.id = UUID().uuidString
        self.class = "topic"
        self.title = title
        self.structureClass = "org.xmind.ui.map.unbalanced"
        self.titleUnedited = true
        self.markers = nil
        self.children = nil
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case `class`
        case title
        case structureClass
        case titleUnedited
        case markers
        case children
    }
}


extension Topic: Equatable {
    public static func == (lhs: Topic, rhs: Topic) -> Bool {
        return lhs === rhs
    }
}
