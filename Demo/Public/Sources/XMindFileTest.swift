//
//  XMindFileTest.swift
//  Demo
//
//  Created by CY H on 2019/11/7.
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
import XMindSDK

func XMindFileTest() {
    guard let filePath = Bundle.main.path(forResource: "example1", ofType: "xmind") else { return }
    testFile(filePath: filePath)
}

private func testFile(filePath: String) {
    
    do {
        
        let wb = try Workbook.open(filePath: filePath)
        try wb.loadManifest()
        try wb.loadContent(password: "123456")
        
        
        
        let s = wb.allSheets
        
        print(s)

//        let wb = try Workbook.new()
        
        
//        let root = wb.sheets.first!.rootTopic
        
//        let sub1 = root.addSubTopic("Sub Topic 1")
//        let sub2 = root.addSubTopic("Sub Topic 2")
//        let sub3 = root.addSubTopic("Sub Topic 3")
//
//        _ = sub3.addSubTopic("Topic 4")
//        _ = sub3.addSubTopic("Topic 5")
//
//        sub2.addMarker(Marker.Arrow.refresh)
//
//        root.addMarker(Marker.Flag.darkBlue)
//
//        sub1.addMarker(Marker.Priority.p2)
//
//
//        let file = NSTemporaryDirectory() + "test.xmind"
//
//        try wb.save(to: file)
        
//        print(file)
        
    } catch let e {
        print(e)
    }
    
}
