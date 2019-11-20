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
public final class Workbook {
    
    private lazy var content_xmlBox = PureJsonStructBox<String>(fileManager: fileManager, path: "content.xml", defaultValue: content_xml)
    
    private lazy var manifestBox = PureJsonStructBox<Manifest>(fileManager: fileManager, path: "manifest.json", defaultValue: Manifest.makeDefault())
    
    private lazy var metadataBox = PureJsonStructBox<Metadata>(fileManager: fileManager, path: "metadata.json", defaultValue: Metadata.makeDefault())
    
    private lazy var sheetsBox = SheetsBox(fileManager: fileManager, manifestBox: manifestBox, metadataBox: metadataBox)

    private let fileManager: FileManager
    
    private var sourcePath: String? = nil
        
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

}

public extension Workbook {
    var manifest: Manifest { manifestBox.model }
    
    var metadata: Metadata { metadataBox.model }
    
    var sheets: [Sheet] { sheetsBox.model }
    
    func addSheet(_ sheet: Sheet) {
        sheetsBox.add(sheet: sheet)
    }
    
    func removeSheet(_ sheet: Sheet) {
        sheetsBox.remove(sheet: sheet)
    }
}


public extension Workbook {
    
    private static func makeTemporaryDirectory() -> String {
        return (NSTemporaryDirectory() as NSString).appendingPathComponent(UUID().uuidString)
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
            let workbook = Workbook(temporaryPathFileManager: fileManager)
            workbook.sourcePath = filePath
            return workbook
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
    
    private func syncTemporaryPath() {
        // Because the sheetsBox may update other boxs. SheetsBox must sync first.
        sheetsBox.syncWithFileIfNeeded()
        manifestBox.syncWithFileIfNeeded()
        metadataBox.syncWithFileIfNeeded()
        content_xmlBox.syncWithFileIfNeeded()
    }
    
    /// Save as a xmind file at the given path.
    /// - Parameter path: Path will save to.
    func save(to path: String) throws {
        syncTemporaryPath()
        if !SSZipArchive.createZipFile(atPath: path, withContentsOfDirectory: fileManager.currentDirectoryPath) {
            throw XMindSDKError.saveFailed
        }
    }
    
    /// Save to the original source path
    /// If the workbook is new created, it has no source path. thus, a noSourcePath error of XMindSDKError will be thrown.
    func save() throws {
        if let path = sourcePath {
            try save(to: path)
        } else {
            throw XMindSDKError.noSourcePath
        }
    }
}
