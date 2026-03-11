//
//  BlueContactViewCell.swift
//  CairYuk
//
//  Created by hekang on 2026/3/11.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class BlueContactViewCell: UITableViewCell {
    
    var oneTapBlock: (() -> Void)?
    
    var twoTapBlock: (() -> Void)?
    
    private let disposeBag = DisposeBag()
    
    var model: cordacityModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.dignical ?? ""
            oneLabel.text = model.relationship_placeholder ?? ""
            twoLabel.text = model.contact_placeholder ?? ""
        }
    }
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return nameLabel
    }()
    
    lazy var oneView: UIView = {
        let oneView = UIView()
        oneView.layer.cornerRadius = 8
        oneView.layer.masksToBounds = true
        oneView.backgroundColor = UIColor.init(hexString: "#F7F8F9")
        return oneView
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hexString: "#949595")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return oneLabel
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "aow_black_image")
        return oneImageView
    }()
    
    lazy var twoView: UIView = {
        let twoView = UIView()
        twoView.layer.cornerRadius = 8
        twoView.layer.masksToBounds = true
        twoView.backgroundColor = UIColor.init(hexString: "#F7F8F9")
        return twoView
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .left
        twoLabel.textColor = UIColor.init(hexString: "#949595")
        twoLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        return twoLabel
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "con_icon_p_image")
        return twoImageView
    }()
    
    lazy var oneBtn: UIButton = {
        let oneBtn = UIButton(type: .custom)
        return oneBtn
    }()
    
    lazy var twoBtn: UIButton = {
        let twoBtn = UIButton(type: .custom)
        return twoBtn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(nameLabel)
        contentView.addSubview(oneView)
        oneView.addSubview(oneImageView)
        oneView.addSubview(oneLabel)
        
        
        contentView.addSubview(twoView)
        twoView.addSubview(twoImageView)
        twoView.addSubview(twoLabel)
        
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 300, height: 20))
        }
        
        oneView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.size.equalTo(CGSize(width: 343.pix(), height: 48.pix()))
        }
        oneImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 15, height: 14))
        }
        
        oneLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.right.equalTo(oneImageView.snp.left).offset(-5)
        }
        
        twoView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(oneView.snp.bottom).offset(16)
            make.size.equalTo(CGSize(width: 343.pix(), height: 48.pix()))
            make.bottom.equalToSuperview().offset(-24)
        }
        twoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-15)
            make.size.equalTo(CGSize(width: 15, height: 14))
        }
        
        twoLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalTo(30)
            make.right.equalTo(twoImageView.snp.left).offset(-5)
        }
        
        oneView.addSubview(oneBtn)
        twoView.addSubview(twoBtn)
        
        oneBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        twoBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        oneBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.oneTapBlock?()
        }).disposed(by: disposeBag)
        
        twoBtn.rx.tap.bind(onNext: { [weak self] in
            guard let self = self else { return }
            self.twoTapBlock?()
        }).disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
