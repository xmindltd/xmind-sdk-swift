//
//  SheetsBox.swift
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

class SheetsBox: FileModelBox {
    
    typealias Model = [Sheet]
    
    var model: [Sheet] = []
    
    func syncWithFileIfNeeded() {
        if needSync {
            if let data = try? JSONEncoder().encode(model) {
                fileManager.createFile(atPath: "content.json", contents: data, attributes: nil)
            }
//            needSync = false
        }
    }
    
    var needSync: Bool = false
    
    private let fileManager: FileManager
    
    private let manifestBox: PureJsonStructBox<Manifest>
    
    private let metadataBox: PureJsonStructBox<Metadata>
    
    init(fileManager: FileManager, manifestBox: PureJsonStructBox<Manifest>, metadataBox: PureJsonStructBox<Metadata>) {
        self.fileManager = fileManager
        self.manifestBox = manifestBox
        self.metadataBox = metadataBox
        
        if let data = fileManager.contents(atPath: "content.json"), let model = try? JSONDecoder().decode([Sheet].self, from: data) {
            self.model = model
        } else {
            let sheet = Sheet(title: "Sheet 1", rootTopic: Topic(title: "Topic 1"))
            self.model = [sheet]
            self.needSync = true
            
            metadataBox.model.activeSheetId = sheet.id
//            sheet.box = self
        }
    }
    
    func add(sheet: Sheet) {
        if model.contains(where: { $0 === sheet }) {
            return
        }
        
        model.append(sheet)
        metadataBox.model.activeSheetId = sheet.id
//        sheet.box = self
//        needSync = true
    }
    
    func remove(sheet: Sheet) {
        _ = model.drop { $0 === sheet }
        metadataBox.model.activeSheetId = model.last?.id ?? ""
//        sheet.box = nil
//        needSync = true
    }
    
}
