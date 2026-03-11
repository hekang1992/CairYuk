//
//  LaunchViewController.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

import UIKit
import SnapKit
import Combine
import RxSwift
import RxCocoa
import FBSDKCoreKit
import IQKeyboardManagerSwift

class LaunchViewController: BaseViewController {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "launch_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var againBtn: UIButton = {
        let againBtn = UIButton(type: .custom)
        againBtn.setTitle("Try again".localized, for: .normal)
        againBtn.setTitleColor(.white, for: .normal)
        againBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        againBtn.isHidden = true
        return againBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(againBtn)
        againBtn.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 100, height: 40))
        }
        
        bindViewModel()
        
        NetworkMonitor.shared.startListen { [weak self] isConnected, statusText in
            guard let self = self else { return }
            if isConnected {
                NetworkMonitor.shared.stopListen()
                viewModel.launchInfo(parameters: [:])
            }else {
                againBtn.isHidden = false
            }
            print("statusText======\(statusText)")
        }
        
        againBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                viewModel.launchInfo(parameters: [:])
            }).disposed(by: disposeBag)
        
    }
    
}

extension LaunchViewController {
    
    private func bindViewModel() {
        
        viewModel.$model
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                
                guard let self, let model else { return }
                
                let securityair = model.securityair ?? ""
                
                if ["0", "00"].contains(securityair) {
                    
                    let prehensship = model.fatherarium?.prehensship ?? ""
                    LanguageManager.shared.configure(with: prehensship)
                    
                    if let faceModel = model.fatherarium?.attorneyeur {
                        self.uploadFaceBookSDKInfo(with: faceModel)
                    }
                    
                    switchToMainTabBar()
                    
                    againBtn.isHidden = true
                }else {
                    againBtn.isHidden = false
                }
                
            }.store(in: &cancellables)
        
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

extension LaunchViewController {
    
    private func uploadFaceBookSDKInfo(with model: attorneyeurModel) {
        
        Settings.shared.displayName = model.everyment ?? ""
        Settings.shared.appURLSchemeSuffix = model.cribrdoctoration ?? ""
        Settings.shared.appID = model.pilair ?? ""
        Settings.shared.clientToken = model.necrify ?? ""
        
        ApplicationDelegate.shared.application(
            UIApplication.shared,
            didFinishLaunchingWithOptions: nil
        )
        
    }
    
}
