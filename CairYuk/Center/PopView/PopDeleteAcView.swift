//
//  PopDeleteAcView.swift
//  CairYuk
//
//  Created by hekang on 2026/3/9.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class PopDeleteAcView: UIView {
    
    let disposeBag = DisposeBag()
    
    var cancelBlock: (() -> Void)?
    
    var sureBlock: (() -> Void)?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "delete_pop_image".localized)
        bgImageView.contentMode = .scaleAspectFit
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        return twoBtn
    }()
    
    lazy var threeBtn: UIButton = {
        let threeBtn = UIButton(type: .custom)
        return threeBtn
    }()
    
    lazy var sureBtn: UIButton = {
        let sureBtn = UIButton(type: .custom)
        sureBtn.setImage(UIImage(named: "loc_nor_image"), for: .normal)
        sureBtn.setImage(UIImage(named: "loc_sel_image"), for: .selected)
        return sureBtn
    }()
    
    lazy var policyLabel: UILabel = {
        let policyLabel = UILabel()
        policyLabel.textAlignment = .left
        policyLabel.text = "I have read and agree to the above"
        policyLabel.textColor = .black
        policyLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return policyLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(oneBtn)
        bgImageView.addSubview(twoBtn)
        bgImageView.addSubview(threeBtn)
        
        bgImageView.addSubview(sureBtn)
        bgImageView.addSubview(policyLabel)
        
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 527.pix()))
        }
        
        oneBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview()
            make.height.width.equalTo(32.pix())
            make.centerX.equalToSuperview()
        }
        
        twoBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalTo(oneBtn.snp.top).offset(-56.pix())
            make.height.equalTo(50.pix())
        }
        
        threeBtn.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.equalToSuperview()
            make.bottom.equalTo(twoBtn.snp.top).offset(-16.pix())
            make.height.equalTo(50.pix())
        }
        
        sureBtn.snp.makeConstraints { make in
            make.width.height.equalTo(16)
            make.left.equalToSuperview().offset(32)
            make.bottom.equalTo(threeBtn.snp.top).offset(-52.pix())
        }
        
        policyLabel.snp.makeConstraints { make in
            make.centerY.equalTo(sureBtn)
            make.left.equalTo(sureBtn.snp.right).offset(8)
            make.height.equalTo(20)
        }
        
        oneBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.cancelBlock?()
            }).disposed(by: disposeBag)
        
        twoBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.sureBlock?()
            }).disposed(by: disposeBag)
        
        threeBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.cancelBlock?()
            }).disposed(by: disposeBag)
        
        sureBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.sureBtn.isSelected.toggle()
            }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
