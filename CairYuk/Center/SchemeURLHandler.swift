//
//  SchemeURLHandler.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/9.
//

import UIKit

let Scheme_URL = "roleative://mortulowy.scalmentionary.onerier/"

class SchemeURLHandler {
    
    static let shared = SchemeURLHandler()
    
    private init() {}
    
    private struct SchemeURL {
        let path: String
        let parameters: [String: String]
    }
    
    private func parseURL(_ urlString: String) -> SchemeURL? {
        guard let url = URL(string: urlString) else {
            return nil
        }
        
        let path = url.path.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        
        let queryItems = URLComponents(url: url, resolvingAgainstBaseURL: false)?.queryItems
        
        let parameters = queryItems?.reduce(into: [String: String]()) { $0[$1.name] = $1.value } ?? [:]
        
        return SchemeURL(path: path, parameters: parameters)
    }
    
    func handleURL(_ urlString: String, from viewController: UIViewController) {
        guard let schemeURL = parseURL(urlString) else { return }
        
        DispatchQueue.main.async { [weak self] in
            self?.navigateToPage(path: schemeURL.path,
                               parameters: schemeURL.parameters,
                               from: viewController)
        }
    }
    
    private func navigateToPage(path: String,
                              parameters: [String: String],
                              from viewController: UIViewController) {
        switch path {
        case "hangacity":
            goToSettingPage(parameters: parameters, from: viewController)
            
        case "legiatic":
            goToHomePage(parameters: parameters, from: viewController)
            
        case "crevate":
            goToLoginPage(parameters: parameters, from: viewController)
            
        case "foli":
            goToOrderListPage(parameters: parameters, from: viewController)
            
        case "majororium":
            goToProductDetailPage(parameters: parameters, from: viewController)
            
        case "amphial":
            goToCustomerServicePage(parameters: parameters, from: viewController)
            
        default:
            break
        }
    }
    
    func goToSettingPage(parameters: [String: String], from viewController: UIViewController) {
        let settingVc = SettingsViewController()
        viewController.navigationController?.pushViewController(settingVc, animated: true)
    }
    
    func goToHomePage(parameters: [String: String], from viewController: UIViewController) {
        self.switchToMainTabBar()
    }
    
    func goToLoginPage(parameters: [String: String], from viewController: UIViewController) {
        SecureUserManager.logout()
        self.switchToMainTabBar()
    }
    
    func goToOrderListPage(parameters: [String: String], from viewController: UIViewController) {
        
    }
    
    func goToProductDetailPage(parameters: [String: String], from viewController: UIViewController) {
        let productVc = ProductViewController()
        productVc.productID = parameters["dentacity"] ?? ""
        viewController.navigationController?.pushViewController(productVc, animated: true)
    }
    
    func goToCustomerServicePage(parameters: [String: String], from viewController: UIViewController) {
        
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
