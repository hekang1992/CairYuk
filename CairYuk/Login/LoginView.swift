//
//  LoginView.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

enum loginViewType: String {
    case toPolicy = "1"
    case toCode
    case toLogin
}

class LoginView: UIView {
    
    var tapClickBlock: ((loginViewType) -> Void)?
    
    private let disposeBag = DisposeBag()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "one_login_image")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 16
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF").withAlphaComponent(0.5)
        return bgView
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.textAlignment = .left
        phoneLabel.text = "Phone number".localized
        phoneLabel.textColor = UIColor.init(hexString: "#333332")
        phoneLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return phoneLabel
    }()
    
    lazy var oneView: UIView = {
        let oneView = UIView()
        oneView.layer.cornerRadius = 8
        oneView.layer.masksToBounds = true
        oneView.backgroundColor = UIColor.init(hexString: "#F6F7FB")
        return oneView
    }()
    
    lazy var phoneImageView: UIImageView = {
        let phoneImageView = UIImageView()
        phoneImageView.image = UIImage(named: "sj_ic_image")
        return phoneImageView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .center
        oneLabel.text = "+91".localized
        oneLabel.textColor = UIColor.init(hexString: "#1F3FA3")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return oneLabel
    }()
    
    lazy var phoneTextFiled: UITextField = {
        let phoneTextFiled = UITextField()
        phoneTextFiled.keyboardType = .numberPad
        phoneTextFiled.placeholder = "Enter phone number".localized
        phoneTextFiled.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        phoneTextFiled.textColor = UIColor.black
        return phoneTextFiled
    }()
    
    lazy var codeLabel: UILabel = {
        let codeLabel = UILabel()
        codeLabel.textAlignment = .left
        codeLabel.text = "Phone number".localized
        codeLabel.textColor = UIColor.init(hexString: "#333332")
        codeLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return codeLabel
    }()
    
    lazy var twoView: UIView = {
        let twoView = UIView()
        twoView.layer.cornerRadius = 8
        twoView.layer.masksToBounds = true
        twoView.backgroundColor = UIColor.init(hexString: "#F6F7FB")
        return twoView
    }()
    
    lazy var codeTextFiled: UITextField = {
        let codeTextFiled = UITextField()
        codeTextFiled.keyboardType = .numberPad
        codeTextFiled.placeholder = "Enter verification code".localized
        codeTextFiled.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        codeTextFiled.textColor = UIColor.black
        return codeTextFiled
    }()
    
    lazy var codeBtn: UIButton = {
        let codeBtn = UIButton(type: .custom)
        codeBtn.setTitle("Get code".localized, for: .normal)
        codeBtn.setTitleColor(.white, for: .normal)
        codeBtn.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        codeBtn.backgroundColor = UIColor.init(hexString: "#3F6EFF")
        codeBtn.layer.cornerRadius = 6
        codeBtn.layer.masksToBounds = true
        return codeBtn
    }()
    
    lazy var loginBtn: UIButton = {
        let loginBtn = UIButton(type: .custom)
        loginBtn.setTitle("Log in".localized, for: .normal)
        loginBtn.setTitleColor(.white, for: .normal)
        loginBtn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        loginBtn.setBackgroundImage(UIImage(named: "login_click_image"), for: .normal)
        return loginBtn
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.setImage(UIImage(named: "loc_nor_image"), for: .normal)
        sureBtn.setImage(UIImage(named: "loc_sel_image"), for: .selected)
        sureBtn.isSelected = true
        return sureBtn
    }()
    
    lazy var policyBtn: UIButton = {
        let policyBtn = UIButton(type: .custom)
        policyBtn.setBackgroundImage(UIImage(named: "loc_en_image".localized), for: .normal)
        return policyBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        addSubview(bgView)
        
        bgView.addSubview(phoneLabel)
        bgView.addSubview(oneView)
        oneView.addSubview(phoneImageView)
        oneView.addSubview(oneLabel)
        oneView.addSubview(phoneTextFiled)
        
        bgView.addSubview(codeLabel)
        bgView.addSubview(twoView)
        twoView.addSubview(codeBtn)
        twoView.addSubview(codeTextFiled)
        
        bgView.addSubview(loginBtn)
        bgView.addSubview(sureBtn)
        bgView.addSubview(policyBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(20.pix())
            make.size.equalTo(CGSize(width: 181, height: 80))
        }
        bgView.snp.makeConstraints { make in
            make.top.equalTo(bgImageView.snp.bottom).offset(17)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 391.pix()))
        }
        phoneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24.pix())
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(14)
        }
        oneView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(phoneLabel.snp.bottom).offset(15.pix())
            make.size.equalTo(CGSize(width: 305.pix(), height: 52.pix()))
        }
        phoneImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(15)
            make.size.equalTo(CGSizeMake(15.pix(), 20.pix()))
        }
        oneLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(phoneImageView.snp.right).offset(2.pix())
            make.width.height.equalTo(30.pix())
        }
        phoneTextFiled.snp.makeConstraints { make in
            make.left.equalTo(oneLabel.snp.right).offset(5.pix())
            make.right.equalToSuperview().offset(-5.pix())
            make.top.bottom.equalToSuperview()
        }
        
        codeLabel.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(30.pix())
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(14)
        }
        twoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(codeLabel.snp.bottom).offset(15.pix())
            make.size.equalTo(CGSize(width: 305.pix(), height: 52.pix()))
        }
        
        codeBtn.snp.makeConstraints { make in
            make.top.bottom.right.equalToSuperview().inset(5.pix())
            make.width.equalTo(80.pix())
        }
        
        codeTextFiled.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.bottom.top.equalToSuperview()
            make.right.equalTo(codeBtn.snp.left).offset(-10.pix())
        }
        
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(twoView.snp.bottom).offset(40.pix())
            make.size.equalTo(CGSize(width: 305.pix(), height: 52.pix()))
        }
        
        sureBtn.snp.makeConstraints { make in
            make.width.height.equalTo(14.pix())
            make.top.equalTo(loginBtn.snp.bottom).offset(25.pix())
            make.left.equalToSuperview().offset(19)
        }
        
        policyBtn.snp.makeConstraints { make in
            make.top.equalTo(sureBtn).offset(1.pix())
            make.left.equalTo(sureBtn.snp.right).offset(5.pix())
            if LanguageManager.shared.currentType == .english {
                make.size.equalTo(CGSizeMake(269.pix(), 12.pix()))
            }else {
                make.size.equalTo(CGSizeMake(223.pix(), 27.pix()))
            }
        }
        
        tapClick()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LoginView {
    
    private func tapClick() {
        
        sureBtn
            .rx
            .tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.sureBtn.isSelected.toggle()
            }).disposed(by: disposeBag)
        
        codeBtn
            .rx
            .tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.tapClickBlock?(.toCode)
            }).disposed(by: disposeBag)
        
        loginBtn
            .rx
            .tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.tapClickBlock?(.toLogin)
            }).disposed(by: disposeBag)
        
        policyBtn
            .rx
            .tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.tapClickBlock?(.toPolicy)
            }).disposed(by: disposeBag)
        
    }
    
}
