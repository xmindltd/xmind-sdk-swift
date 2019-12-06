//
//  TemporaryStorge.swift
//  XMindSDK
//
//  Created by h on 2019/12/5.
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

class TemporaryStorge {
    
    private let fileManager = FileManager()
    let temporaryPath: String
    
    init(temporaryPath: String, createDirectory: Bool) throws {
        self.temporaryPath = temporaryPath
        
        if createDirectory {
            do {
                try fileManager.createDirectory(atPath: temporaryPath, withIntermediateDirectories: true, attributes: nil)
            } catch {
                throw Error.temporaryFolderCreationFailed
            }
        }
    }
    
    private func makeAbsolutelyPath(path: String) -> String {
        return (temporaryPath as NSString).appendingPathComponent(path)
    }
    
    func read(path: String) throws -> Data {
        if let data = fileManager.contents(atPath: makeAbsolutelyPath(path: path)) {
            return data
        }
        throw Error.fileNotFound
    }
    
    func write(path: String, data: Data) throws {
        fileManager.createFile(atPath: makeAbsolutelyPath(path: path), contents: data, attributes: nil)
    }
    
    func clear() {
        do {
            try fileManager.removeItem(atPath: temporaryPath)
        } catch {
            print("XMindSDK: Fail to clean the temporary file. The temporary directory is \"\(temporaryPath)\".")
        }
    }
    
    static func makeTemporaryDirectory() -> String {
        return (NSTemporaryDirectory() as NSString).appendingPathComponent(UUID().uuidString)
    }
}
