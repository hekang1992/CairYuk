//
//  LanguageManager.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

import Foundation

class LanguageManager {
    static let shared = LanguageManager()
    
    private let userDefaults = UserDefaults.standard
    private let languageKey = "AppLanguage"
    
    enum LanguageCode: String {
        case english = "40"
        case indonesian = "39"
        
        var displayName: String {
            switch self {
            case .english: return "English"
            case .indonesian: return "Indonesia"
            }
        }
    }
    
    private(set) var currentLanguage: LanguageCode = .english
    
    private init() {
        if let savedLanguage = userDefaults.string(forKey: languageKey),
           let language = LanguageCode(rawValue: savedLanguage) {
            currentLanguage = language
        }
    }
    
    func setLanguage(_ language: LanguageCode) {
        currentLanguage = language
        userDefaults.set(language.rawValue, forKey: languageKey)
    }
    
    func localizedString(_ key: String) -> String {
        guard let path = Bundle.main.path(forResource: currentLanguage.rawValue, ofType: "lproj"),
              let bundle = Bundle(path: path) else {
            return NSLocalizedString(key, comment: "")
        }
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
}

extension String {
    var localized: String {
        return LanguageManager.shared.localizedString(self)
    }
}
