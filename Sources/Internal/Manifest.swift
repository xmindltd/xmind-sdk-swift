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

/// A file entry indicates a file in this xmind file bundle. And some file have they own description which contains some information which mainly indicates encryption data now,
/// Manifest also contains the password hint. If you wanna access it form an existing file. you must call `loadManifest` before accessing.
struct Manifest: Codable {
    
    /// All the file entries.
    private(set) var fileEntries: [String: Description] = [:]
    
    /// The password hint.
    var passwordHint: String?
    
    enum CodingKeys: String, CodingKey {
        case fileEntries = "file-entries"
        case passwordHint = "password-hint"
    }
    
    /// Insert a file entry with the file name and it's description.
    /// - Parameters:
    ///   - fileEntry: Name of the file entry.
    ///   - description: Description of this file entry.
    mutating func insert(fileEntry: String, description: Description = Description(encryptionData: nil)) {
        fileEntries[fileEntry] = description
    }
    
    /// Remove a file entry by name.
    /// - Parameter fileEntry: Name of the file entry.
    mutating func remove(fileEntry: String) {
        fileEntries.removeValue(forKey: fileEntry)
    }
    
    func encryptionData(fileEntry: String) -> EncryptionData? {
        return fileEntries[fileEntry]?.encryptionData
    }
    
    static func makeDefault() -> Manifest {
        var manifest = Manifest()
        manifest.insert(fileEntry: Constants.sheetsPath)
        manifest.insert(fileEntry: Constants.metadataPath)
        return manifest
    }
}

extension Manifest {
    struct Description: Codable {
        public let encryptionData: EncryptionData?
        
        enum CodingKeys: String, CodingKey {
            case encryptionData = "encryption-data"
        }
    }
}
