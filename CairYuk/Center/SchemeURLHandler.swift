//
//  SchemeURLHandler.swift
//  CairYuk
//
//  Created by hekang on 2026/3/9.
//

import UIKit

let Scheme_URL = "roleative://mortulowy.scalmentionary.onerier/"

class SchemeURLHandler {
    
    static let shared = SchemeURLHandler()
    
    private init() {}
    
    private weak var navigationController: UINavigationController?
    
    func configure(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    private struct SchemeURL {
        let path: String
        let parameters: [String: String]
    }
    
    // MARK: - 解析URL
    private func parseURL(_ urlString: String) -> SchemeURL? {
        guard let url = URL(string: urlString),
              let components = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            return nil
        }
        
        let path = components.path.replacingOccurrences(of: "/", with: "")
        
        var parameters: [String: String] = [:]
        components.queryItems?.forEach { item in
            parameters[item.name] = item.value
        }
        
        return SchemeURL(path: path, parameters: parameters)
    }
    
    func handleURL(_ urlString: String) {
        guard let schemeURL = parseURL(urlString) else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.navigateToPage(path: schemeURL.path, parameters: schemeURL.parameters)
        }
    }
    
    private func navigateToPage(path: String, parameters: [String: String]) {
        guard navigationController != nil else {
            return
        }
        
        switch path {
        case "hangacity":
            goToSettingPage(parameters: parameters)
            
        case "legiatic":
            goToHomePage(parameters: parameters)
            
        case "crevate":
            goToLoginPage(parameters: parameters)
            
        case "foli":
            goToOrderListPage(parameters: parameters)
            
        case "majororium":
            goToProductDetailPage(parameters: parameters)
            
        case "amphial":
            goToCustomerServicePage(parameters: parameters)
            
        default:
            break
        }
    }
    
    func goToSettingPage(parameters: [String: String]) {
        let settingVc = SettingsViewController()
        navigationController?.pushViewController(settingVc, animated: true)
    }
    
    func goToHomePage(parameters: [String: String]) {
        self.switchToMainTabBar()
    }
    
    func goToLoginPage(parameters: [String: String]) {
        SecureUserManager.logout()
        self.switchToMainTabBar()
    }
    
    func goToOrderListPage(parameters: [String: String]) {
        
    }
    
    func goToProductDetailPage(parameters: [String: String]) {
        
    }
    
    func goToCustomerServicePage(parameters: [String: String]) {
        
    }
}

extension SchemeURLHandler {
    
    private func switchToMainTabBar() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let tabBarController = BaseTabBarController()
        
        UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve) {
            window.rootViewController = tabBarController
        }
    }
    
}
