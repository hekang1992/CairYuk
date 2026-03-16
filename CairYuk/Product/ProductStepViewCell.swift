//
//  ProductStepViewCell.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/10.
//

import UIKit
import SnapKit
import Kingfisher

class ProductStepViewCell: UITableViewCell {
    
    var model: listensiveModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.seeketic ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = model.participantarian ?? ""
            typeLabel.text = model.pteratory ?? ""
            
            let arhitty = model.arhitty ?? 0
            
            typeView.backgroundColor = arhitty == 1 ? UIColor.init(hexString: "#ECF0FF") : UIColor.init(hexString: "#3F6EFF")
            
            if arhitty == 1 {
                typeImageView.image = UIImage(named: "cg_image_icon")
            }else {
                typeImageView.image = LanguageManager.shared.currentType == .indonesian ? UIImage(named: "go_nd_icon_image") : UIImage(named: "go_n_icon_image")
            }
            
        }
    }
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.layer.cornerRadius = 5
        logoImageView.layer.masksToBounds = true
        return logoImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        return nameLabel
    }()
    
    lazy var typeLabel: UILabel = {
        let typeLabel = UILabel()
        typeLabel.textAlignment = .left
        typeLabel.textColor = .black
        typeLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return typeLabel
    }()
    
    lazy var grayView: UIView = {
        let grayView = UIView()
        grayView.layer.cornerRadius = 12
        grayView.layer.masksToBounds = true
        grayView.backgroundColor = UIColor.init(hexString: "#8E8E8E")
        return grayView
    }()
    
    lazy var whiteView: UIView = {
        let whiteView = UIView()
        whiteView.layer.cornerRadius = 12
        whiteView.layer.masksToBounds = true
        whiteView.backgroundColor = UIColor.init(hexString: "#F8F9FB")
        return whiteView
    }()
    
    lazy var typeView: UIView = {
        let typeView = UIView()
        typeView.layer.cornerRadius = 6
        typeView.layer.masksToBounds = true
        typeView.backgroundColor = UIColor.init(hexString: "#ECF0FF")
        return typeView
    }()
    
    lazy var typeImageView: UIImageView = {
        let typeImageView = UIImageView()
        typeImageView.contentMode = .center
        return typeImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(grayView)
        grayView.addSubview(whiteView)
        whiteView.addSubview(logoImageView)
        whiteView.addSubview(nameLabel)
        whiteView.addSubview(typeLabel)
        whiteView.addSubview(typeView)
        typeView.addSubview(typeImageView)
        grayView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 339.pix(), height: 78.pix()))
            make.bottom.equalToSuperview().offset(-12.pix())
        }
        whiteView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.right.equalToSuperview().offset(-5.pix())
        }
        logoImageView.snp.makeConstraints { make in
            make.width.height.equalTo(57)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(8)
        }
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalTo(logoImageView.snp.right).offset(16)
            make.height.equalTo(20)
        }
        typeLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(8)
            make.left.equalTo(logoImageView.snp.right).offset(16)
            make.height.equalTo(20)
        }
        typeView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(40)
        }
        typeImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

