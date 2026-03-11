//
//  BaseTabBarController.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/8.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
        self.delegate = self
        let homeVC = createViewController(
            viewController: HomeViewController(),
            title: "",
            defaultImageName: "home_nor_image",
            selectedImageName: "home_sel_image"
        )
        
        let orderVC = createViewController(
            viewController: OrderViewController(),
            title: "",
            defaultImageName: "order_nor_image",
            selectedImageName: "order_sel_image"
        )
        
        let profileVC = createViewController(
            viewController: CenterViewController(),
            title: "",
            defaultImageName: "mine_nor_image",
            selectedImageName: "mine_sel_image"
        )
       
        viewControllers = [homeVC, orderVC, profileVC]
    }
    
    private func createViewController(viewController: UIViewController, title: String, defaultImageName: String, selectedImageName: String) -> UINavigationController {
        
        let defaultImage = UIImage(named: defaultImageName) ?? UIImage(systemName: defaultImageName)
        let selectedImage = UIImage(named: selectedImageName) ?? UIImage(systemName: selectedImageName)
        
        viewController.tabBarItem.image = defaultImage?.withRenderingMode(.alwaysOriginal)
        viewController.tabBarItem.selectedImage = selectedImage?.withRenderingMode(.alwaysOriginal)
        
        viewController.tabBarItem.title = nil
        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        let navController = BaseNavigationController(rootViewController: viewController)
        navController.navigationBar.isTranslucent = false
        
        return navController
    }
    
}

extension BaseTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if !SecureUserManager.isLoggedIn() {
            self.popLoginVc()
            return false
        }
        return true
    }
}

extension BaseTabBarController {
    
    private func popLoginVc() {
        let loginVc = LoginViewController()
        let navVc = BaseNavigationController(rootViewController: loginVc)
        navVc.modalPresentationStyle = .overFullScreen
        self.present(navVc, animated: true)
    }
    
}
