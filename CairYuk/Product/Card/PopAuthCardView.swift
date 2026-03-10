//
//  PopAuthCardView.swift
//  CairYuk
//
//  Created by hekang on 2026/3/10.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class PopAuthCardView: UIView {
    
    var model: fatherariumModel? {
        didSet {
            guard let model = model else { return }
            oneTextFiled.text = model.traveleous ?? ""
            twoTextFiled.text = model.lucmomentair ?? ""
            threeTextFiled.text = model.spherdom ?? ""
        }
    }
    
    var cancelBlock: (() -> Void)?
    
    var sureBlock: ((String, String, String) -> Void)?
    
    private let disposeBag = DisposeBag()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "ncp_a_d_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        twoBtn.setTitle("Confirm".localized, for: .normal)
        twoBtn.setTitleColor(UIColor.white, for: .normal)
        twoBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        twoBtn.setBackgroundImage(UIImage(named: "con_a_bt_image"), for: .normal)
        twoBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        return twoBtn
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hexString: "#333333")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        oneLabel.text = "Real name".localized
        return oneLabel
    }()
    
    lazy var oneView: UIView = {
        let oneView = UIView()
        oneView.layer.cornerRadius = 8
        oneView.layer.masksToBounds = true
        oneView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return oneView
    }()
    
    lazy var oneTextFiled: UITextField = {
        let oneTextFiled = UITextField()
        oneTextFiled.placeholder = "Real name".localized
        oneTextFiled.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        oneTextFiled.textColor = UIColor.black
        return oneTextFiled
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .left
        twoLabel.textColor = UIColor.init(hexString: "#333333")
        twoLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        twoLabel.text = "PAN number".localized
        return twoLabel
    }()
    
    lazy var twoView: UIView = {
        let twoView = UIView()
        twoView.layer.cornerRadius = 8
        twoView.layer.masksToBounds = true
        twoView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return twoView
    }()
    
    lazy var twoTextFiled: UITextField = {
        let twoTextFiled = UITextField()
        twoTextFiled.placeholder = "PAN number".localized
        twoTextFiled.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        twoTextFiled.textColor = UIColor.black
        return twoTextFiled
    }()
    
    lazy var threeLabel: UILabel = {
        let threeLabel = UILabel()
        threeLabel.textAlignment = .left
        threeLabel.textColor = UIColor.init(hexString: "#333333")
        threeLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        threeLabel.text = "Date of birth".localized
        return threeLabel
    }()
    
    lazy var threeView: UIView = {
        let threeView = UIView()
        threeView.layer.cornerRadius = 8
        threeView.layer.masksToBounds = true
        threeView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return threeView
    }()
    
    lazy var threeTextFiled: UITextField = {
        let threeTextFiled = UITextField()
        threeTextFiled.placeholder = "Date of birth".localized
        threeTextFiled.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        threeTextFiled.textColor = UIColor.black
        threeTextFiled.isSelected = false
        return threeTextFiled
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        return threeBtn
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "aow_black_image")
        return logoImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(oneBtn)
        bgImageView.addSubview(twoBtn)
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 537.pix()))
        }
        
        oneBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(32.pix())
        }
        
        twoBtn.snp.makeConstraints { make in
            make.bottom.equalTo(oneBtn.snp.top).offset(-32.pix())
            make.centerX.equalToSuperview()
            make.width.equalTo(261.pix())
            make.height.equalTo(65.pix())
        }
        
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(oneView)
        oneView.addSubview(oneTextFiled)
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(100.pix())
            make.left.equalToSuperview().offset(35.pix())
            make.height.equalTo(14.pix())
        }
        
        oneView.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(12)
            make.left.equalTo(oneLabel)
            make.centerX.equalToSuperview()
            make.height.equalTo(48.pix())
        }
        
        oneTextFiled.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15.pix())
            make.right.equalToSuperview().offset(-5.pix())
        }
        
        bgImageView.addSubview(twoLabel)
        bgImageView.addSubview(twoView)
        twoView.addSubview(twoTextFiled)
        
        twoLabel.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(35.pix())
            make.height.equalTo(14.pix())
        }
        
        twoView.snp.makeConstraints { make in
            make.top.equalTo(twoLabel.snp.bottom).offset(12)
            make.left.equalTo(oneLabel)
            make.centerX.equalToSuperview()
            make.height.equalTo(48.pix())
        }
        
        twoTextFiled.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15.pix())
            make.right.equalToSuperview().offset(-5.pix())
        }
        
        bgImageView.addSubview(threeLabel)
        bgImageView.addSubview(threeView)
        threeView.addSubview(threeTextFiled)
        threeView.addSubview(threeBtn)
        
        threeLabel.snp.makeConstraints { make in
            make.top.equalTo(twoView.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(35.pix())
            make.height.equalTo(14.pix())
        }
        
        threeView.snp.makeConstraints { make in
            make.top.equalTo(threeLabel.snp.bottom).offset(12)
            make.left.equalTo(oneLabel)
            make.centerX.equalToSuperview()
            make.height.equalTo(48.pix())
        }
        
        threeTextFiled.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15.pix())
            make.right.equalToSuperview().offset(-5.pix())
        }
        
        threeBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        threeView.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 15, height: 14))
        }
        
        bindTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PopAuthCardView {
    
    private func bindTap() {
        
        oneBtn
            .rx
            .tap
            .bind(onNext: { [weak self] in
                self?.cancelBlock?()
            })
            .disposed(by: disposeBag)
        
        twoBtn
            .rx
            .tap
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                let name = oneTextFiled.text ?? ""
                let number = twoTextFiled.text ?? ""
                let time = threeTextFiled.text ?? ""
                self.sureBlock?(name, number, time)
            })
            .disposed(by: disposeBag)
        
        threeBtn
            .rx
            .tap
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.showTimeView(time: threeTextFiled.text ?? "")
            })
            .disposed(by: disposeBag)
        
    }
}

extension PopAuthCardView {
    
    private func showTimeView(time: String) {
        
        let grayView = UIView()
        grayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        let bgImageView = UIImageView()
        bgImageView.isUserInteractionEnabled = true
        bgImageView.image = UIImage(named: "ncp_a_d_image")
        
        let clickBtn = UIButton(type: .custom)
        
        let timeView = TimeView(frame: .zero)
        
        timeView.setDate(from: time)
        
        timeView.onConfirm = { [weak self] dateString in
            guard let self = self else { return }
            self.threeTextFiled.text = dateString
            grayView.removeFromSuperview()
            bgImageView.removeFromSuperview()
        }
        
        clickBtn.rx.tap.bind(onNext: {
            grayView.removeFromSuperview()
            bgImageView.removeFromSuperview()
        }).disposed(by: disposeBag)
        
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            window.addSubview(grayView)
            window.addSubview(bgImageView)
            bgImageView.addSubview(clickBtn)
            bgImageView.addSubview(timeView)
            grayView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
            bgImageView.snp.makeConstraints { make in
                make.center.equalToSuperview()
                make.size.equalTo(CGSize(width: 343.pix(), height: 537.pix()))
            }
            clickBtn.snp.makeConstraints { make in
                make.bottom.equalToSuperview()
                make.centerX.equalToSuperview()
                make.width.height.equalTo(32.pix())
            }
            timeView.snp.makeConstraints { make in
                make.top.equalToSuperview().offset(86.pix())
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 319.pix(), height: 370.pix()))
            }
        }
    }
    
}
