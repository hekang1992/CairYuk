//
//  ProductStepViewCell.swift
//  CairYuk
//
//  Created by hekang on 2026/3/10.
//

import UIKit
import SnapKit

class ProductStepViewCell: UITableViewCell {
    
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

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(grayView)
        grayView.addSubview(whiteView)
        whiteView.addSubview(logoImageView)
        whiteView.addSubview(nameLabel)
        whiteView.addSubview(typeLabel)
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
