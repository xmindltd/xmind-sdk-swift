//
//  Builders.swift
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

/// Create a new topic with the title.
public func topic(title: String) -> Elements<Topic> {
    return Elements<Topic>(Topic(title: title))
}

/// Create a new topic with the title and the childen.
public func topic(title: String, @ElementsBuilder<Topic> childen: () -> Elements<Topic>) -> Elements<Topic> {
    let topic = Topic(title: title)
    childen().forEach { topic.addSubTopic($0) }
    return Elements<Topic>(topic)
}

/// Create a new sheet by a root topic.
public func sheet(title: String, rootTopic: () -> Elements<Topic>) -> Elements<Sheet> {
    guard let first = rootTopic().first else { return Elements<Sheet>() }
    return Elements<Sheet>(Sheet(title: title, rootTopic: first))
}

/// Create a new Workbook object by sheets.
public func workbook(@ElementsBuilder<Sheet> sheets: () -> Elements<Sheet>) throws -> Workbook {
    let workbook = try Workbook.new()
    sheets().forEach { workbook.add(sheet: $0) }
    return workbook
}

/// Create a new Workbook object by topics.
/// This function will make sheets for each root topics.
public func workbook(@ElementsBuilder<Topic> childen: () -> Elements<Topic>) throws -> Workbook {
    try workbook {
        Elements<Sheet>(childen().map { Elements<Sheet>(Sheet(title: "Sheet", rootTopic: $0)) })
    }
}
