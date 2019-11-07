//
//  Workbook.swift
//  XMindSDK
//
//  Created by CY H on 2019/11/4.
//

import Foundation
import ZipArchive

public class Workbook {
    
    private let fileManager: FileManager
    
    public convenience init(filePath: String) throws {
        try self.init(filePath: filePath, temporaryPath: Self.makeTemporaryPath())
    }
    
    public init(filePath: String, temporaryPath: String) throws {
        
        let fileManager = FileManager()
        
        guard fileManager.fileExists(atPath: filePath) else {
            throw XMindSDKError.fileNotFound
        }
        
        guard SSZipArchive.unzipFile(atPath: filePath, toDestination: temporaryPath) else {
            throw XMindSDKError.extractFile
        }
        
        if fileManager.changeCurrentDirectoryPath(temporaryPath) {
            self.fileManager = fileManager
        } else {
            throw XMindSDKError.extractFile
        }
    }
    
    deinit {
        do {
            try fileManager.removeItem(atPath: fileManager.currentDirectoryPath)
        } catch {
            print("XMindSDK: Fail to clean the temporary file. File path is \"\(fileManager.currentDirectoryPath)\".")
        }
    }
    

    public func save() {
        
    }
    
    private static func makeTemporaryPath() -> String {
        return NSTemporaryDirectory() + UUID().uuidString
    }
}
