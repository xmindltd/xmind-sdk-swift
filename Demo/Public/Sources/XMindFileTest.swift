//
//  XMindFileTest.swift
//  Demo
//
//  Created by CY H on 2019/11/7.
//

import Foundation
import XMindSDK


func XMindFileTest() {
    guard let filePath = Bundle.main.path(forResource: "example0", ofType: "xmind") else { return }
    testFile(filePath: filePath)
}


private func testFile(filePath: String) {
    
    var wb = try? Workbook(filePath: filePath)

}
