//
//  TwoViewCell.swift
//  CairYuk
//
//  Created by hekang on 2026/3/10.
//

import UIKit
import SnapKit

class TwoViewCell: UITableViewCell {
    
    var model: ambrememberuousModel? {
        didSet {
            guard let model = model else { return }
            oneLabel.text = model.participantarian ?? ""
            oneTextFiled.placeholder = model.spargenne ?? ""
        }
    }
    
    lazy var oneLabel: UILabel = {
        let oneLabel = UILabel()
        oneLabel.textAlignment = .left
        oneLabel.textColor = UIColor.init(hexString: "#333333")
        oneLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        return oneLabel
    }()
    
    lazy var oneView: UIView = {
        let oneView = UIView()
        oneView.layer.cornerRadius = 8
        oneView.layer.masksToBounds = true
        oneView.backgroundColor = UIColor.init(hexString: "#F7F8F9")
        return oneView
    }()
    
    lazy var oneTextFiled: UITextField = {
        let oneTextFiled = UITextField()
        oneTextFiled.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        oneTextFiled.textColor = UIColor.black
        oneTextFiled.isEnabled = false
        return oneTextFiled
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        return clickBtn
    }()
    
    lazy var logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "aow_black_image")
        return logoImageView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(oneLabel)
        contentView.addSubview(oneView)
        oneView.addSubview(logoImageView)
        oneView.addSubview(oneTextFiled)
        contentView.addSubview(clickBtn)
        
        oneLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(16.pix())
            make.height.equalTo(18.pix())
        }
        
        oneView.snp.makeConstraints { make in
            make.top.equalTo(oneLabel.snp.bottom).offset(12)
            make.left.equalTo(oneLabel)
            make.centerX.equalToSuperview()
            make.height.equalTo(48.pix())
            make.bottom.equalToSuperview().offset(-24.pix())
        }
        
        logoImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
            make.size.equalTo(CGSize(width: 15, height: 14))
        }
        
        oneTextFiled.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15.pix())
            make.right.equalTo(logoImageView.snp.left).offset(-5.pix())
        }
        
        clickBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
