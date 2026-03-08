//
//  LaunchViewController.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

import UIKit
import IQKeyboardManagerSwift
import SnapKit
import Combine
import FBSDKCoreKit

class LaunchViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    private var cancellables = Set<AnyCancellable>()
        
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "launch_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bindViewModel()
        
        viewModel.launchInfo(parameters: [:])
        
//        switchToMainTabBar()
    }
    
}

extension LaunchViewController {
    
    private func bindViewModel() {
        
        viewModel.$model
                .receive(on: DispatchQueue.main)
                .sink { [weak self] model in
                    
                    guard let model else { return }
                    
                    print("数据来了:", model)
                    
                   
                    
                }
                .store(in: &cancellables)
        
    }
    
    private func switchToMainTabBar() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let tabBarController = BaseTabBarController()
        
        UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve) {
            window.rootViewController = tabBarController
        }
    }
    
}
