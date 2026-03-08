//
//  SecureUserManager.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

import Foundation

class SecureUserManager {
    
    private static let phoneKey = "user_phone"
    private static let tokenKey = "user_token"
    
    static func savePhone(_ phone: String) {
        UserDefaults.standard.set(phone, forKey: phoneKey)
    }
    
    static func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    static func saveUser(phone: String, token: String) {
        savePhone(phone)
        saveToken(token)
    }
    
    static func getPhone() -> String? {
        return UserDefaults.standard.string(forKey: phoneKey)
    }
    
    static func getToken() -> String? {
        return UserDefaults.standard.string(forKey: tokenKey)
    }
    
    static func isLoggedIn() -> Bool {
        guard let phone = getPhone(), !phone.isEmpty,
              let token = getToken(), !token.isEmpty else {
            return false
        }
        return true
    }
    
    static func logout() {
        UserDefaults.standard.removeObject(forKey: phoneKey)
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
}
