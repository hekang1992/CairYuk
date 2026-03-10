//
//  ProductCardView.swift
//  CairYuk
//
//  Created by hekang on 2026/3/10.
//

import UIKit
import SnapKit
import Kingfisher

class ProductCardView: UIView {
    
    var model: baloarianModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.acriestablish ?? ""
            oneLabel.text = model.phasyform ?? ""
            twoLabel.text = model.ventise ?? ""
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "pd_head_bg_image")
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(twoLabel)
        
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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
