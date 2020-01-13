//
//  Crypto.swift
//  XMindSDK
//
//  Created by h on 2019/12/5.
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
import CryptoSwift

class Crypto {
    
    static let algorithmName = "AES/CBC/PKCS5Padding"
    static let keyDerivationName = "PBKDF2WithHmacSHA512"
    
    private let password: String
    
    init(password: String) {
        self.password = password
    }
    
    func decrypt(data: Data, encryptionData: EncryptionData) throws -> Data {
        
        guard let salt = Data(base64Encoded: encryptionData.salt) else { throw Error.encryptionDataDamaged }
        guard let iv = Data(base64Encoded: encryptionData.iv) else { throw Error.encryptionDataDamaged }
        
        let PBKDF2 = try PKCS5.PBKDF2(password: password.bytes,
                                      salt: salt.bytes,
                                      iterations: encryptionData.iterationCount,
                                      keyLength: encryptionData.size / 8,
                                      variant: .sha512)
        let key = try PBKDF2.calculate()
        
        
        let aes = try AES(key: key, blockMode: CBC(iv: iv.bytes), padding: .pkcs5)
        return Data(try aes.decrypt(data.bytes))
    }
    
    func encrypt(data: Data) throws -> (data: Data, encryptionData: EncryptionData) {
        let salt = generateSaltData()
        let iv = generateIVData()
        
        let encryptionData = EncryptionData(iterationCount: 1024,
                                            size: 128,
                                            algorithmName: Crypto.algorithmName,
                                            keyDerivationName: Crypto.keyDerivationName,
                                            salt: salt.base64EncodedString(),
                                            iv: iv.base64EncodedString())
        
        let PBKDF2 = try PKCS5.PBKDF2(password: password.bytes,
                                      salt: salt.bytes,
                                      iterations: encryptionData.iterationCount,
                                      keyLength: encryptionData.size / 8,
                                      variant: .sha512)
        
        let key = try PBKDF2.calculate()

        let aes = try AES(key: key, blockMode: CBC(iv: iv.bytes), padding: .pkcs5)
        
        let encryptedData = Data(try aes.encrypt(data.bytes))
        
        return (data: encryptedData, encryptionData: encryptionData)
    }
    
    private func generateIVData() -> Data {
        randomData(size: 16)
    }
    
    private func generateSaltData() -> Data {
        randomData(size: 8)
    }
    
    private func randomData(size: Int) -> Data {
        var data = Data(capacity: size)
        for _ in 0..<size {
            data.append(UInt8.random(in: 0...255))
        }
        return data
    }
}
