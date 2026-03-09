//
//  CenterViewCell.swift
//  CairYuk
//
//  Created by hekang on 2026/3/9.
//

import UIKit
import SnapKit
import Kingfisher

class CenterViewCell: UITableViewCell {
    
    var model: publicficModel? {
        didSet {
            guard let model = model else { return }
            let logoUrl = model.popularship ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            
            nameLabel.text = model.participantarian ?? ""
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
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return nameLabel
    }()

    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "right_icon_image")
        return oneImageView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        return bgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(bgView)
        bgView.addSubview(logoImageView)
        bgView.addSubview(nameLabel)
        bgView.addSubview(oneImageView)
        
        bgView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(44)
            make.bottom.equalToSuperview().offset(-15)
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(29)
            make.width.height.equalTo(22)
        }
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalTo(logoImageView.snp.right).offset(10)
            make.height.equalTo(20)
        }
        oneImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-32)
            make.size.equalTo(CGSize(width: 9, height: 14))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
