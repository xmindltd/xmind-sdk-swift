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
    
    /// The unique ID of this topic.
    public let id: String
    
    public let `class`: String?
    
    public var title: String?
    
    public let structureClass: String?
    
    public let titleUnedited: Bool?
    
    public private(set) var markers: [Marker]?
    
    public private(set) var children: Children?
    
    private var image: Image?
    
    internal private(set) weak var superTopic: Topic? = nil
    

    public init(title: String? = nil) {
        self.id = UUID().uuidString
        self.class = "topic"
        self.title = title
        self.structureClass = "org.xmind.ui.map.unbalanced"
        self.titleUnedited = true
        self.markers = nil
        self.children = nil
    }
    
}

extension Topic {
    public struct Children: Codable {
        public var attached: [Topic]?
        public var detached: [Topic]?
        
        init() {
            attached = []
            detached = []
        }
    }
}

extension Topic {
    
    struct Image: Codable {
        let src: String
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case `class`
        case title
        case structureClass
        case titleUnedited
        case markers
        case children
        case image
    }
}

extension Topic {
    /// Add a topic to self.
    /// You cant add an ancestor topic, It do nothing.
    /// If the topic that to be added was alredy contained by self. it will not add twice.
    /// If the topic had a super topic, it will remove from origin super topic,then add to self.
    /// - Parameter topic: The topic to be added.
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
    
    /// A convenience function for add a topic.
    /// The behave is same as "addSubTopic(_ topic: Topic)".
    /// The returned topic is the new created topic.
    /// - Parameter title: Title of the new topic.
    public func addSubTopic(_ title: String) -> Topic {
        let topic = Topic(title: title)
        addSubTopic(topic)
        return topic
    }
    
    /// Remove a sub topic.
    /// - Parameter topic: The sub topic.
    public func removeSubTopic(_ topic: Topic) {
        
        guard let droped = children?.attached?.drop(while: { $0 === topic }) else { return }
        
        for topic in droped {
            topic.superTopic = nil
        }
    }
    
    /// If the topic has a super topic, it will remove from the super topic.
    public func removeFromSuperTopic() {
        superTopic?.removeSubTopic(self)
    }
    
    /// Add a marker to the topic, The same class marker can only add once.
    /// - Parameter marker: Marker to be added.
    public func addMarker(_ marker: Marker) {
        if markers == nil {
            markers = [marker]
        } else {
            markers!.removeAll { $0.isSameGroup(with: marker) }
            markers!.append(marker)
        }
    }
    
    /// Remove a marker.
    /// - Parameter marker: Marker to be removed.
    public func removeMarker(_ marker: Marker) {
        markers?.removeAll { $0 == marker }
    }
}


extension Topic: Equatable {
    public static func == (lhs: Topic, rhs: Topic) -> Bool {
        return lhs === rhs
    }
}
