//
//  Theme.swift
//  XMindSDK
//
//  Created by h on 2019/11/13.
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

public struct Theme: Codable {
    
    public struct Item: Codable {
        let styleId: String?
        let type: String?
        let properties: [String: String]?
    }
    
    public let id: String
    
    public let importantTopic: Item?
    public let minorTopic: Item?
    public let expiredTopic: Item?
    public let centralTopic: Item?
    public let boundary: Item?
    public let floatingTopic: Item?
    public let subTopic: Item?
    public let mainTopic: Item?
    public let calloutTopic: Item?
    public let summary: Item?
    public let summaryTopic: Item?
    public let relationship: Item?
    public let map: Item?
    public let level3: Item?
    
    static let snowbrush: Theme = {
        return try! JSONDecoder().decode(Theme.self, from: theme_snowbrush.data(using: .utf8)!)
    }()
}
