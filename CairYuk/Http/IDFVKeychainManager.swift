//
//  IDFVKeychainManager.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//


import Foundation
import UIKit
import Security
import AdSupport

class IDFVKeychainManager {
    
    static let shared = IDFVKeychainManager()
    private init() {}
    
    private let service = "com.yourapp.idfv.service"
    private let account = "com.yourapp.idfv.account"
    
    func getIDFA() -> String {
        let idfa = ASIdentifierManager.shared().advertisingIdentifier.uuidString
        return idfa
    }
    
    func getIDFV() -> String {
        if let idfv = loadFromKeychain() {
            return idfv
        }
        
        if let newIDFV = UIDevice.current.identifierForVendor?.uuidString {
            saveToKeychain(newIDFV)
            return newIDFV
        }
        
        return ""
    }
    
    private func loadFromKeychain() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        guard status == errSecSuccess,
              let data = item as? Data,
              let idfv = String(data: data, encoding: .utf8) else {
            return nil
        }
        
        return idfv
    }
    
    private func saveToKeychain(_ idfv: String) {
        guard let data = idfv.data(using: .utf8) else { return }
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: data,
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock
        ]
        
        SecItemDelete(query as CFDictionary)
        
        SecItemAdd(query as CFDictionary, nil)
    }
    
    func deleteIDFV() {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account
        ]
        
        SecItemDelete(query as CFDictionary)
    }
    
    func updateIDFV() -> String {
        deleteIDFV()
        
        if let newIDFV = UIDevice.current.identifierForVendor?.uuidString {
            saveToKeychain(newIDFV)
            return newIDFV
        }
        
        return ""
    }
    
    func hasIDFVInKeychain() -> Bool {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: kCFBooleanTrue!,
            kSecMatchLimit as String: kSecMatchLimitOne
        ]
        
        var item: CFTypeRef?
        let status = SecItemCopyMatching(query as CFDictionary, &item)
        
        return status == errSecSuccess
    }
}
