//
//  LoginViewController.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/8.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa
import Combine

class LoginViewController: BaseViewController {
    
    private let countdownSeconds = 60
    
    private var remainingSeconds = 0
    
    private var countdownTimer: Timer?
    
    private var onetime: String = ""
    
    private var twotime: String = ""
    
    private let location = AppLocationManager()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "login_bg_image")
        bgImageView.contentMode = .scaleAspectFill
        return bgImageView
    }()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setBackgroundImage(UIImage(named: "back_bg_image"), for: .normal)
        return backBtn
    }()
    
    lazy var loginView: LoginView = {
        let loginView = LoginView()
        return loginView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(backBtn)
        backBtn.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(15)
            make.left.equalToSuperview().offset(20.pix())
            make.width.height.equalTo(24)
        }
        
        view.addSubview(loginView)
        loginView.snp.makeConstraints { make in
            make.top.equalTo(backBtn.snp.bottom).offset(30)
            make.left.right.bottom.equalToSuperview()
        }
        
        bindTap()
        
        viewModel.$codeModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                
                guard let self, let model else { return }
                
                let securityair = model.securityair ?? ""
                
                if ["0", "00"].contains(securityair) {
                    startCountdown()
                    self.loginView.codeTextFiled.becomeFirstResponder()
                }
                ToastManager.showOnWindow(model.northature ?? "")
            }.store(in: &cancellables)
        
        
        viewModel.$loginModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                
                guard let self, let model else { return }
                
                let securityair = model.securityair ?? ""
                ToastManager.showOnWindow(model.northature ?? "")
                if ["0", "00"].contains(securityair) {
                    let phone = model.fatherarium?.almostice ?? ""
                    let token = model.fatherarium?.patriise ?? ""
                    
                    SecureUserManager.saveUser(phone: phone, token: token)
                    
                    Task {
                        try? await Task.sleep(nanoseconds: 1_000_000_000)
                        
                        self.followInfo(step: "1",
                                        productID: "",
                                        OrderID: "",
                                        starttime: self.onetime,
                                        endtime: self.twotime)
                    }
                    
                    self.switchToMainTabBar()
                }
            }.store(in: &cancellables)
        
        onetime = self.getFollowTime()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.loginView.phoneTextFiled.becomeFirstResponder()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self = self else { return }
            location.startLocation { result, error in }
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        stopCountdown()
    }
    
    private func startCountdown() {
        stopCountdown()
        
        remainingSeconds = countdownSeconds
        updateCodeButtonTitle()
        
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1.0,
                                              repeats: true) { [weak self] _ in
            guard let self = self else { return }
            
            if self.remainingSeconds > 0 {
                self.remainingSeconds -= 1
                self.updateCodeButtonTitle()
            } else {
                self.stopCountdown()
                self.resetCodeButton()
            }
        }
        
        RunLoop.current.add(countdownTimer!, forMode: .common)
    }
    
    private func stopCountdown() {
        countdownTimer?.invalidate()
        countdownTimer = nil
    }
    
    private func updateCodeButtonTitle() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.loginView.codeBtn.setTitle("\(self.remainingSeconds)s", for: .normal)
            self.loginView.codeBtn.isEnabled = false
        }
    }
    
    private func resetCodeButton() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.loginView.codeBtn.setTitle("Get code".localized, for: .normal)
            self.loginView.codeBtn.isEnabled = true
        }
    }
    
}

extension LoginViewController {
    
    private func bindTap() {
        
        backBtn
            .rx
            .tap
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.dismiss(animated: true)
            }).disposed(by: disposeBag)
        
        loginView.tapClickBlock = { [weak self] type in
            guard let self = self else { return }
            
            switch type {
            case .toCode:
                self.codeInfo()
                
            case .toLogin:
                self.loginInfo()
                
            case .toPolicy:
                self.poliyInfo()
            }
            
        }
        
    }
    
    private func codeInfo() {
        let phone = self.loginView.phoneTextFiled.text ?? ""
        if phone.isEmpty {
            ToastManager.showOnWindow("Enter phone number".localized)
            return
        }
        
        let parameters = ["ratherine": phone]
        viewModel.codeInfo(parameters: parameters)
        
    }
    
    private func loginInfo() {
        
        twotime = self.getFollowTime()
        
        self.loginView.phoneTextFiled.resignFirstResponder()
        
        self.loginView.codeTextFiled.resignFirstResponder()
        
        let phone = self.loginView.phoneTextFiled.text ?? ""
        let code = self.loginView.codeTextFiled.text ?? ""
        if phone.isEmpty {
            ToastManager.showOnWindow("Enter phone number".localized)
            return
        }
        if code.isEmpty {
            ToastManager.showOnWindow("Enter verification code".localized)
            return
        }
        
        let parameters = ["almostice": phone, "hetero": code]
        viewModel.loginInfo(parameters: parameters)
        
    }
    
    private func poliyInfo() {
        let pageUrl = h5_url + "/rhizfy"
        self.goWebVc(pageUrl: pageUrl)
    }
    
}

extension LoginViewController {
    
    private func switchToMainTabBar() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let tabBarController = BaseTabBarController()
        
        UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve) {
            window.rootViewController = tabBarController
        }
    }
    
}
