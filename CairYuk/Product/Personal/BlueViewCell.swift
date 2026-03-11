//
//  BlueViewCell.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/11.
//

import UIKit
import SnapKit

class BlueViewCell: UITableViewCell {
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .center
        nameLabel.textColor = UIColor.black
        nameLabel.font = UIFont.systemFont(ofSize: 15, weight: .medium)
        return nameLabel
    }()

    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.layer.cornerRadius = 24.pix()
        bgView.layer.masksToBounds = true
        bgView.backgroundColor = UIColor.init(hexString: "#FFFFFF")
        return bgView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(bgView)
        bgView.addSubview(nameLabel)
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 295.pix(), height: 48.pix()))
            make.bottom.equalToSuperview().offset(-14)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
