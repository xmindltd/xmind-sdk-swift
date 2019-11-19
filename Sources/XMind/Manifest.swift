//
//  Manifest.swift
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

public struct Manifest: Codable, CustomStringConvertible {
    
    private var _fileEntries: [String: Empty] = [:]
    
    private struct Empty: Codable {
        
    }
    
    public init(fileEntries: String...) {
        fileEntries.forEach {
            insert(fileEntrie: $0)
        }
    }
    
    enum CodingKeys: String, CodingKey {
        case _fileEntries = "file-entries"
    }
    
    public var fileEntries: Set<String> {
        Set(_fileEntries.keys)
    }
    
    public var description: String {
        return fileEntries.description
    }
    
    public mutating func insert(fileEntrie: String) {
        _fileEntries[fileEntrie] = Empty()
    }
    
    public mutating func remove(fileEntrie: String) {
        _fileEntries.removeValue(forKey: fileEntrie)
    }
    
    
    static func makeDefault() -> Manifest {
        return Manifest(fileEntries: "content.json", "metadata.json")
    }
    
}
