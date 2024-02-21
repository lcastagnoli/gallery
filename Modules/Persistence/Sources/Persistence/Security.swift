//
//  Security.swift
//
//
//  Created by Laryssa Castagnoli on 21/02/24.
//

import CryptoKit
import Security
import Foundation

public enum SecurityKey: String {

    case guestSession
}
enum CryptoError: Error {
    case encryptionFailed
    case decryptionFailed
}
public protocol SecurityProtocol {

    func save(_ value: String, key: String)
    func delete(key: String)
    func get(key: String) -> String?
}

public final class Security: SecurityProtocol {

    public init() {}

    public func save(_ value: String, key: String) {

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecValueData as String: value
        ]
        SecItemAdd(query as CFDictionary, nil)
    }

    public func delete(key: String) {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key
        ]
        
        SecItemDelete(query as CFDictionary)
    }

    public func get(key: String) -> String? {

        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrAccount as String: key,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        var keyData: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &keyData)
        guard let data = keyData as? Data, status == errSecSuccess else { return nil }
        return SymmetricKey(data: data).withUnsafeBytes { Data($0) }.base64EncodedString()
    }
}
