//
//  ContentView.swift
//  Demo
//
//  Created by CY H on 2019/11/8.
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


import SwiftUI
import XMindSDK

///
/// The example0.xmind file has no password.
/// The password of example1.xmind file is "123456".

struct Row: Identifiable {
    let id: String
    let title: String
    let indentLevel: Int
}

struct TopicCell: View {
    
    let row: Row
    
    private var _title: String {
        return "| " + String(repeating: " - ", count: row.indentLevel) + row.title
    }
    
    var body: some View {
        Text(_title)
    }
}

struct ContentView: View {
    
    private func makeRows(from topic: Topic, indentLevel: Int) -> [Row] {
        var rows = [Row]()
        rows.append(Row(id: topic.id, title: topic.title ?? "", indentLevel: indentLevel))
        if let attachedChildren = topic.children?.attached {
            for topic in attachedChildren {
                rows.append(contentsOf: makeRows(from: topic, indentLevel: indentLevel + 1))
            }
        }
        return rows
    }
    
    private func makeRows(from sheet: Sheet) -> [Row] {
        var rows = [Row]()
        rows.append(Row(id: sheet.id, title: sheet.title, indentLevel: 0))
        rows.append(contentsOf: makeRows(from: sheet.rootTopic, indentLevel: 1))
        return rows
    }

    private func makeRows() -> [Row] {
        guard let filePath = Bundle.main.path(forResource: "example0", ofType: "xmind") else { return [] }
        
        do {
            let wb = try Workbook.open(filePath: filePath)
            try wb.loadManifest()
            try wb.loadContent()
            
            var rows = [Row]()
            
            for sheet in wb.allSheets {
                rows.append(contentsOf: makeRows(from: sheet))
            }
            
            return rows
            
        } catch let error {
            print(error)
            return []
        }
    }
    
    
    var body: some View {
        List(makeRows()) {
            TopicCell(row: $0)
        }
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
