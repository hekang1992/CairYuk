//
//  SettingsViewController.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

import UIKit
import RxSwift
import SnapKit
import Combine
import MJRefresh
import RxCocoa
import TYAlertController

class SettingsViewController: BaseViewController {
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "app_head_bg_image")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = "Account".localized
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return nameLabel
    }()
    
    lazy var headView: AppHeadView = {
        let headView = AppHeadView(frame: .zero)
        headView.configTile(with: "Settings".localized)
        return headView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 8.pix()
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return bgView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "set_icon_image")
        logoImageView.contentMode = .scaleAspectFit
        return logoImageView
    }()
    
    lazy var versionLabel: UILabel = {
        let versionLabel = UILabel()
        versionLabel.textAlignment = .center
        versionLabel.text = "Version：1.0.0".localized
        versionLabel.textColor = .black
        versionLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return versionLabel
    }()
    
    lazy var tapOutBtn: UIButton = {
        let tapOutBtn = UIButton(type: .custom)
        tapOutBtn.setBackgroundImage(UIImage(named: "set_out_image".localized), for: .normal)
        tapOutBtn.adjustsImageWhenHighlighted = false
        return tapOutBtn
    }()
    
    lazy var deleteBtn: UIButton = {
        let deleteBtn = UIButton(type: .custom)
        deleteBtn.setTitle("Cancel account", for: .normal)
        deleteBtn.setTitleColor(.black, for: .normal)
        deleteBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        deleteBtn.isHidden = LanguageManager.shared.currentType == .indonesian ? true : false
        return deleteBtn
    }()
    
    lazy var lineView: UIView = {
        let lineView = UIView()
        lineView.layer.cornerRadius = 2
        lineView.layer.masksToBounds = true
        lineView.backgroundColor = .black
        return lineView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "#3F6EFF")
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(269.pix())
        }
        
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(44.pix())
        }
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        bgView.addSubview(logoImageView)
        bgView.addSubview(versionLabel)
        bgView.addSubview(tapOutBtn)
        bgView.addSubview(deleteBtn)
        deleteBtn.addSubview(lineView)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(32)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 80.pix(), height: 112.pix()))
        }
        
        versionLabel.snp.makeConstraints { make in
            make.height.equalTo(15)
            make.centerX.equalToSuperview()
            make.top.equalTo(logoImageView.snp.bottom).offset(10)
        }
        
        tapOutBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345.pix(), height: 50.pix()))
            make.top.equalTo(versionLabel.snp.bottom).offset(24.pix())
        }
        
        deleteBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-90)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 110, height: 18))
        }
        
        lineView.snp.makeConstraints { make in
            make.left.bottom.right.equalToSuperview()
            make.height.equalTo(1)
        }
        
        headView.backBlock = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        viewModel.$outModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self, let model else { return }
                
                let securityair = model.securityair ?? ""
                ToastManager.showOnWindow(model.northature ?? "")
                if ["0", "00"].contains(securityair) {
                    self.dismiss(animated: true)
                    SecureUserManager.logout()
                    self.switchToMainTabBar()
                }
            }.store(in: &cancellables)
        
        viewModel.$deleteModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                
                guard let self, let model else { return }
                
                let securityair = model.securityair ?? ""
                ToastManager.showOnWindow(model.northature ?? "")
                if ["0", "00"].contains(securityair) {
                    self.dismiss(animated: true)
                    SecureUserManager.logout()
                    self.switchToMainTabBar()
                }
                
            }.store(in: &cancellables)
        
        bindTap()
        
    }
    
}

extension SettingsViewController {
    
    func bindTap() {
        
        tapOutBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.popOutView()
            }).disposed(by: disposeBag)
        
        deleteBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.popDeleteView()
            }).disposed(by: disposeBag)
        
    }
    
}

extension SettingsViewController {
    
    private func popOutView() {
        let popView = PopAccountView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        popView.sureBlock = { [weak self] in
            guard let self = self else { return }
            viewModel.outInfo(parameters: [:])
        }
    }
    
    private func popDeleteView() {
        
        let popView = PopDeleteAcView(frame: self.view.bounds)
        let alertVc = TYAlertController(alert: popView, preferredStyle: .alert)
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        popView.sureBlock = { [weak self] in
            guard let self = self else { return }
            if popView.sureBtn.isSelected == false {
                ToastManager.showOnWindow("Please read and agree to the above")
                return
            }
            viewModel.deleteInfo(parameters: [:])
        }
        
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
