//
//  Workbook.swift
//  XMindSDK
//
//  Created by CY H on 2019/11/4.
//

import Foundation
import Zip

public class Workbook {
    
    init(filePath: String, temporaryPath: String = makeTemporaryPath()) throws {
        
    }
    

    func save() {
        
    }
    
    
    private init() {
        
    }
    
    private static func makeTemporaryPath() -> String {
        return NSTemporaryDirectory() + "/" + UUID().uuidString
    }
}
