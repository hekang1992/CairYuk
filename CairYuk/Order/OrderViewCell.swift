//
//  OrderViewCell.swift
//  CairYuk
//
//  Created by hekang on 2026/3/10.
//

import UIKit
import SnapKit
import Kingfisher

class OrderViewCell: UITableViewCell {
    
    var model: cordacityModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.recentlyian ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            nameLabel.text = model.acriestablish ?? ""
            
            oneLabel.text = model.ceivofress ?? ""
            twoLabel.text = model.aesthetian ?? ""
            
            let descStr = model.ground?.ludture ?? ""
            let time = model.ground?.pastacity ?? ""
            
            threeLabel.text = String(format: "%@: %@", descStr, time)
            
            let typeStr = model.ground?.cosmatuous ?? ""
            
            typeLabel.text = typeStr
            
            typeLabel.isHidden = typeStr.isEmpty ? true : false
            
            let backColor = model.showColor ?? ""
            
            typeLabel.backgroundColor = UIColor.init(hexString: backColor)
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "men_bg_image")
        bgImageView.isUserInteractionEnabled = true
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
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        return nameLabel
    }()
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hexString: "#7C8294")
        oneLabel.font = UIFont.systemFont(ofSize: 12, weight: .regular)
        return oneLabel
    }()
    
    lazy var twoLabel: UILabel = {
        let twoLabel = UILabel()
        twoLabel.textAlignment = .left
        twoLabel.textColor = .black
        twoLabel.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        return twoLabel
    }()
    
    lazy var threeLabel: UILabel = {
        let threeLabel = UILabel()
        threeLabel.textAlignment = .left
        threeLabel.textColor = .black
        threeLabel.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        return threeLabel
    }()
    
    lazy var typeLabel: PaddingLabel = {
        let typeLabel = PaddingLabel()
        typeLabel.textAlignment = .center
        typeLabel.textColor = .white
        typeLabel.font = UIFont.systemFont(ofSize: 11, weight: .semibold)
        typeLabel.layer.cornerRadius = 14
        typeLabel.layer.masksToBounds = true
        return typeLabel
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(bgImageView)
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(nameLabel)
        
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(twoLabel)
        bgImageView.addSubview(threeLabel)
        
        bgImageView.addSubview(typeLabel)
        
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 345.pix(), height: 151.pix()))
            make.bottom.equalToSuperview().offset(-12.pix())
        }
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(12.pix())
            make.left.equalToSuperview().offset(24)
            make.width.height.equalTo(30.pix())
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(8)
            make.height.equalTo(20)
        }
        
        oneLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalToSuperview().offset(66.pix())
            make.height.equalTo(16.pix())
        }
        
        twoLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(oneLabel.snp.bottom).offset(4.pix())
            make.height.equalTo(24.pix())
        }
        
        threeLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(16)
            make.top.equalTo(twoLabel.snp.bottom).offset(12.pix())
            make.height.equalTo(15.pix())
        }
        
        typeLabel.snp.makeConstraints { make in
            make.height.equalTo(30)
            make.right.equalToSuperview().offset(-12)
            make.top.equalToSuperview().offset(66.pix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

