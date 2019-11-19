//
//  PureJsonStructBox.swift
//  XMindSDK
//
//  Created by h on 2019/11/14.
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

final class PureJsonStructBox<PureJsonStructModel: Codable>: FileModelBox {
    
    typealias Model = PureJsonStructModel
    
    var model: PureJsonStructModel {
        didSet {
            needSync = true
        }
    }
    
    func syncWithFileIfNeeded() {
        if needSync {
            if let data = try? JSONEncoder().encode(model) {
                fileManager.createFile(atPath: path, contents: data, attributes: nil)
            }
            needSync = false
        }
    }
    
    private(set) var needSync: Bool = false
    
    private let fileManager: FileManager
    private let path: String
    
    init(fileManager: FileManager, path: String, defaultValue: @autoclosure () -> PureJsonStructModel) {
        self.fileManager = fileManager
        self.path = path
        
        if let data = fileManager.contents(atPath: path), let model = try? JSONDecoder().decode(PureJsonStructModel.self, from: data) {
            self.model = model
        } else {
            self.model = defaultValue()
            self.needSync = true
        }
        
    }
}
