//
//  LanguageManager.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

import Foundation

enum LanguageType: String {
    case indonesian = "39"
    case english    = "40"
}

class LanguageManager {
    
    static let shared = LanguageManager()
    
    private let userDefaults = UserDefaults.standard
    private let languageKey = "AppLanguage"
    
    private(set) var currentBundle: Bundle = .main
    private(set) var currentType: LanguageType = .english
    
    private init() {
        if let savedLanguage = userDefaults.string(forKey: languageKey),
           let language = LanguageType(rawValue: savedLanguage) {
            currentType = language
        }
        
        configure(with: currentType.rawValue)
    }
    
    func configure(with externalID: String?) {
        if externalID == "39" {
            currentType = .indonesian
        } else {
            currentType = .english
        }
        
        userDefaults.set(currentType.rawValue, forKey: languageKey)
        
        let langCode = (currentType == .indonesian) ? "id" : "en"
        
        if let path = Bundle.main.path(forResource: langCode, ofType: "lproj"),
           let bundle = Bundle(path: path) {
            self.currentBundle = bundle
        } else {
            self.currentBundle = .main
        }
    }
    
    func localizedString(_ key: String) -> String {
        return NSLocalizedString(key, bundle: currentBundle, comment: "")
    }
}

extension String {
    var localized: String {
        return LanguageManager.shared.localizedString(self)
    }
}
