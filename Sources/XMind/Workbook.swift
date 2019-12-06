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
/// If open an existing file, first you need call 'loadManifest()' , second call 'loadContent(password: String?)'.
///
public final class Workbook {
    
    private let jsonDecoder = JSONDecoder()
    private let jsonEncoder = JSONEncoder()
    
    private let temporaryStorge: TemporaryStorge
    
    private lazy var manifest: Manifest = Manifest.makeDefault()
    
    private lazy var sheets: [Sheet] = [Sheet(title: "Sheet 1", rootTopic: Topic(title: "Topic 1"))]
    
    private lazy var metadata: Metadata = Metadata.makeDefault(activeSheetId: sheets.last?.id ?? "")
    
    private init(temporaryStorge: TemporaryStorge) {
        self.temporaryStorge = temporaryStorge
    }
    
    deinit {
        temporaryStorge.clear()
    }
}



extension Workbook {
    
    public var passwordHint: String? {
        get {
            return manifest.passwordHint
        }
        set {
            manifest.passwordHint = newValue
        }
    }
    
    /// Load the existing manifest.
    /// Just  only can read passwordHint after called "loadManifest"
    public func loadManifest() throws {
        manifest = try readManifest()
    }
    
    /// Load the existing content.
    /// - Parameter password: Password of the file.
    public func loadContent(password: String?) throws {
        let crypto = makeCrypto(password: password)
        metadata = try readModel(path: Constants.metadataPath, crypto: crypto)
        sheets = try readModel(path: Constants.sheetsPath, crypto: crypto)
    }
    
    public var allSheets: [Sheet] {
        return sheets
    }
    
    public func add(sheet: Sheet) {
        sheets.removeAll { $0 == sheet }
        metadata.activeSheetId = sheet.id
        sheets.append(sheet)
    }
    
    public func remove(sheet: Sheet) {
        sheets.removeAll { $0 == sheet }
        metadata.activeSheetId = sheets.last?.id ?? ""
    }
    
    /// Save as a xmind file at the given path.
    /// - Parameter path: Path will save to.
    public func save(to path: String, password: String?) throws {
        let crypto = makeCrypto(password: password)
        try writeWorkbook(crypto: crypto)
        if !SSZipArchive.createZipFile(atPath: path, withContentsOfDirectory: temporaryStorge.temporaryPath) {
            throw Error.saveFailed
        }
    }
}


extension Workbook {
    
    /// Open a xmind file at the given file path.
    /// It will make a random temporary path by default.
    /// - Parameter filePath: The location of a xmind file which will be opened.
    public static func open(filePath: String) throws -> Workbook {
        return try open(filePath: filePath, temporaryPath: TemporaryStorge.makeTemporaryDirectory())
    }
    
    /// Open a xmind file at the given file path.
    /// - Parameters:
    ///   - filePath: The location of a xmind file which will be opened.
    ///   - temporaryPath: The temporary space that use to cache and opera temporary files.
    public static func open(filePath: String, temporaryPath: String) throws -> Workbook {
        guard FileManager.default.fileExists(atPath: filePath) else {
            throw Error.fileNotFound
        }
        
        guard SSZipArchive.unzipFile(atPath: filePath, toDestination: temporaryPath) else {
            throw Error.fileDamaged
        }
        
        let temporaryStorge = try TemporaryStorge(temporaryPath: temporaryPath, createDirectory: false)
        
        return Workbook(temporaryStorge: temporaryStorge)
    }
    
    /// Create a new xmind file that is empty.
    /// - Parameter temporaryPath: The temporary space that use to cache and opera temporary files.
    public static func new(temporaryPath: String) throws -> Workbook {
        
        let temporaryStorge = try TemporaryStorge(temporaryPath: temporaryPath, createDirectory: true)
        
        return Workbook(temporaryStorge: temporaryStorge)
    }
    
    /// Create  a new xmind file that is empty.
    /// It will make a random temporary path by default.
    public static func new() throws -> Workbook {
        return try new(temporaryPath: TemporaryStorge.makeTemporaryDirectory())
    }
}

private extension Workbook {
    
    func makeCrypto(password: String?) -> Crypto? {
        if let password = password {
            return Crypto(password: password)
        } else {
            return nil
        }
    }
    
    func readManifest() throws -> Manifest {
        let data = try temporaryStorge.read(path: Constants.manifestPath)
        return try jsonDecoder.decode(Manifest.self, from: data)
    }
    
    func writeManifest(manifest: Manifest) throws {
        let data = try jsonEncoder.encode(manifest)
        try temporaryStorge.write(path: Constants.manifestPath, data: data)
    }
    
    func readFile(path: String, crypto: Crypto?) throws -> Data {
        let data = try temporaryStorge.read(path: path)
        if let encryptionData = manifest.encryptionData(fileEntrie: path) {
            if let crypto = crypto {
                return try crypto.decrypt(data: data, encryptionData: encryptionData)
            } else {
                throw Error.fileIsEncrypted
            }
        } else {
            return data
        }
        
    }
    
    func readModel<T: Codable>(path: String, crypto: Crypto?) throws -> T {
        let data = try readFile(path: path, crypto: crypto)
        return try jsonDecoder.decode(T.self, from: data)
    }
    
    func writeFile(path: String, data: Data, crypto: Crypto?) throws {
        if let crypto = crypto {
            let (encryptedData, encryptionData) = try crypto.encrypt(data: data)
            try temporaryStorge.write(path: path, data: encryptedData)
            manifest.insert(fileEntrie: path, description: Manifest.Description(encryptionData: encryptionData))
        } else {
            try temporaryStorge.write(path: path, data: data)
            manifest.insert(fileEntrie: path)
        }
    }
    
    func writeModel<T: Codable>(path: String, model: T, crypto: Crypto?) throws {
        let data = try jsonEncoder.encode(model)
        try writeFile(path: path, data: data, crypto: crypto)
    }
    
    func writeWorkbook(crypto: Crypto?) throws {
        try writeModel(path: Constants.sheetsPath, model: sheets, crypto: crypto)
        try writeModel(path: Constants.metadataPath, model: metadata, crypto: crypto)
        try writeManifest(manifest: manifest)
    }
}
