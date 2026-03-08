//
//  LoginViewController.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class LoginViewController: BaseViewController {
    
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
            make.top.equalTo(backBtn.snp.bottom).offset(40)
            make.left.right.bottom.equalToSuperview()
        }
        
        bindTap()
    }

}

extension LoginViewController {
    
    private func bindTap() {
        
        backBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.dismiss(animated: true)
        }).disposed(by: disposeBag)
        
        
        
    }
    
}
