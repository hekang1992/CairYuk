//
//  HomeCardView.swift
//  CairYuk
//
//  Created by hekang on 2026/3/9.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

class HomeCardView: UIView {
    
    private let disposeBag = DisposeBag()
    
    var tapBlock: ((String) -> Void)?
    
    var model: foldfishessModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.acriestablish ?? ""
            oneLabel.text = model.opisthperiodcy ?? ""
            twoLabel.text = model.representic ?? ""
            applyBtn.setTitle(model.withoutess ?? "", for: .normal)
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "home_card_bg_image")
        return bgImageView
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.init(hexString: "#333333")
        nameLabel.font = UIFont.systemFont(ofSize: 13, weight: .bold)
        return nameLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .center
        oneLabel.textColor = UIColor.init(hexString: "#333333")
        oneLabel.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .center
        twoLabel.textColor = UIColor.init(hexString: "#1F3FA3")
        twoLabel.font = UIFont.systemFont(ofSize: 50, weight: .black)
        return twoLabel
    }()
    
    lazy var rateImageView: UIImageView = {
        let rateImageView = UIImageView()
        rateImageView.image = UIImage(named: "rater_bg_image")
        return rateImageView
    }()
    
    lazy var applyBtn: UIButton = {
        let applyBtn = UIButton(type: .custom)
        applyBtn.setTitleColor(.white, for: .normal)
        applyBtn.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        applyBtn.setBackgroundImage(UIImage(named: "apply_a_b_image"), for: .normal)
        return applyBtn
    }()
    
    lazy var tapClickBtn: UIButton = {
        let tapClickBtn = UIButton(type: .custom)
        return tapClickBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(twoLabel)
        bgImageView.addSubview(rateImageView)
        bgImageView.addSubview(applyBtn)
        addSubview(tapClickBtn)
        
        bgImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16.pix())
            make.left.equalToSuperview().offset(24.pix())
            make.width.height.equalTo(30.pix())
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(8)
            make.height.equalTo(20)
        }
        
        oneLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(62.pix())
            make.height.equalTo(15)
        }
        
        twoLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(oneLabel.snp.bottom).offset(5.pix())
            make.height.equalTo(52.pix())
        }
        
        rateImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 269.pix(), height: 28.pix()))
            make.top.equalTo(twoLabel.snp.bottom).offset(6.pix())
        }
        
        applyBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(rateImageView.snp.bottom).offset(16.pix())
            make.size.equalTo(CGSize(width: 327.pix(), height: 48.pix()))
        }
        
        tapClickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bindTap()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeCardView {
    
    private func bindTap() {
        
        tapClickBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self, let model else { return }
                let productID = String(model.maciactuallyally ?? 0)
                self.tapBlock?(productID)
            }).disposed(by: disposeBag)
        
    }
    
}
