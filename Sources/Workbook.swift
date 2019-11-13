//
//  Workbook.swift
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
import ZipArchive

/// A workbook is as a xmind file.
/// You can open or new a workbook(xmind file).
/// To opera a xmind file, workbook use a temporary storge at temporary path on the disk.
/// The temporary content will be deleted while the workbook object deinited.
public class Workbook {
    
    
    
    public lazy var manifest: Manifest = {
        return decode(Manifest.self, subPath: "manifest.json") ?? Manifest()
    }()
    
    public lazy var metadata: Metadata = {
        return decode(Metadata.self, subPath: "metadata.json") ?? Metadata()
    }()
    
    public lazy var content: [Sheet] = {
        return decode([Sheet].self, subPath: "content.json") ?? []
    }()
    
    private let fileManager: FileManager
    
    private let jsonDecoder = JSONDecoder()
    
    private init(temporaryPathFileManager: FileManager) {
        fileManager = temporaryPathFileManager
    }
    
    deinit {
        do {
            try fileManager.removeItem(atPath: fileManager.currentDirectoryPath)
        } catch {
            print("XMindSDK: Fail to clean the temporary file. File path is \"\(fileManager.currentDirectoryPath)\".")
        }
    }
    
    private func fetchData(subPath: String) -> Data? {
        return fileManager.contents(atPath: subPath)
    }
    
    private func writeData(subPath: String, data: Data) {
        fileManager.createFile(atPath: subPath, contents: data, attributes: nil)
    }
    
    private func decode<T>(_ type: T.Type, subPath: String) -> T? where T : Decodable {
        if let data = fetchData(subPath: subPath) {
            return try? jsonDecoder.decode(type, from: data)
        }
        return nil
    }
    
    private func syncTemporaryPath() {
        
    }
}


public extension Workbook {
    
    private static func makeTemporaryDirectory() -> String {
        return NSTemporaryDirectory() + UUID().uuidString
    }
    
    /// Open a xmind file at the given file path.
    /// It will make a random temporary path by default.
    /// - Parameter filePath: The location of a xmind file which will be opened.
    static func open(filePath: String) throws -> Workbook {
        return try open(filePath: filePath, temporaryPath: makeTemporaryDirectory())
    }
    
    /// Open a xmind file at the given file path.
    /// - Parameters:
    ///   - filePath: The location of a xmind file which will be opened.
    ///   - temporaryPath: The temporary space that use to cache and opera temporary files.
    static func open(filePath: String, temporaryPath: String) throws -> Workbook {
        let fileManager = FileManager()
        
        guard fileManager.fileExists(atPath: filePath) else {
            throw XMindSDKError.fileNotFound
        }
        
        guard SSZipArchive.unzipFile(atPath: filePath, toDestination: temporaryPath) else {
            throw XMindSDKError.fileDamaged
        }
        
        if fileManager.changeCurrentDirectoryPath(temporaryPath) {
            return Workbook(temporaryPathFileManager: fileManager)
        } else {
            throw XMindSDKError.temporaryFolderCreationFailed
        }
    }
    
    /// Create a new xmind file that is empty.
    /// - Parameter temporaryPath: The temporary space that use to cache and opera temporary files.
    static func new(temporaryPath: String) throws -> Workbook {
        let fileManager = FileManager()
        
        do {
            try fileManager.createDirectory(atPath: temporaryPath, withIntermediateDirectories: true, attributes: nil)
        } catch {
            throw XMindSDKError.temporaryFolderCreationFailed
        }
        
        if fileManager.changeCurrentDirectoryPath(temporaryPath) {
            return Workbook(temporaryPathFileManager: fileManager)
        } else {
            throw XMindSDKError.temporaryFolderCreationFailed
        }
    }
    
    /// Create  a new xmind file that is empty.
    /// It will make a random temporary path by default.
    static func new() throws -> Workbook {
        return try new(temporaryPath: makeTemporaryDirectory())
    }
}

public extension Workbook {
    
    func save(to path: String) throws {
        syncTemporaryPath()
        if !SSZipArchive.createZipFile(atPath: path, withContentsOfDirectory: fileManager.currentDirectoryPath) {
            throw XMindSDKError.saveFailed
        }
    }
}
