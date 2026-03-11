//
//  AppHeadView.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/9.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class AppHeadView: UIView {
    
    var backBlock: (() -> Void)?
    
    let disposeBag = DisposeBag()
    
    lazy var backBtn: UIButton = {
        let backBtn = UIButton(type: .custom)
        backBtn.setBackgroundImage(UIImage(named: "app_back_image"), for: .normal)
        return backBtn
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return nameLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(backBtn)
        bgView.addSubview(nameLabel)
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        backBtn.snp.makeConstraints { make in
            make.width.height.equalTo(24.pix())
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(20)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(backBtn.snp.right).offset(12)
            make.height.equalTo(20)
        }
        
        backBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.backBlock?()
            }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension AppHeadView {
    
    func configTile(with title: String) {
        self.nameLabel.text = title
    }
    
}
