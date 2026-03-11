//
//  DeviceInfoCollector.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/8.
//

import Foundation
import UIKit
import AdSupport
import DeviceKit

class DeviceInfoCollector {
    
    func collectAllParameters() -> [String: String] {
        var parameters: [String: String] = [:]
        
        parameters["nothingize"] = "ios"
        
        parameters["attentionress"] = getAppVersion()
        
        parameters["maybeer"] = getDeviceName()
        
        let idfv = IDFVKeychainManager.shared.getIDFV()
        
        parameters["pyling"] = idfv
        
        parameters["catwonderlet"] = idfv
        
        parameters["clystdog"] = getOSVersion()
        
        parameters["mutmost"] = getMarketChannel()
        
        parameters["patriise"] = SecureUserManager.getToken() ?? ""
        
        parameters["prehensship"] = getCurrentLanguage()
        
        parameters["thalaman"] = IDFVKeychainManager.shared.getIDFA()
        
        return parameters
    }
    
    private func getAppVersion() -> String {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "1.0.0"
    }
    
    private func getDeviceName() -> String {
        return Device.current.description
    }
    
    private func getOSVersion() -> String {
        return UIDevice.current.systemVersion
    }
    
    private func getMarketChannel() -> String {
        return "appstore-uagki"
    }
    
    private func getCurrentLanguage() -> String {
        return LanguageManager.shared.currentType == .indonesian ? "39" : "40"
    }
    
}
