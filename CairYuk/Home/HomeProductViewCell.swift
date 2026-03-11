//
//  HomeProductViewCell.swift
//  CairYuk
//
//  Created by hekang on 2026/3/11.
//

import UIKit
import SnapKit
import Kingfisher
import RxSwift
import RxCocoa

class HomeProductViewCell: UITableViewCell {
    
    private let disposeBag = DisposeBag()
    
    var tapBlock: ((String) -> Void)?
    
    var model: foldfishessModel? {
        didSet {
            guard let model = model else { return }
            nameLabel.text = model.acriestablish ?? ""
            oneLabel.text = model.opisthperiodcy ?? ""
            twoLabel.text = model.representic ?? ""
            
            let logoUrl = model.recentlyian ?? ""
            logoImageView.kf.setImage(with: URL(string: logoUrl))
            
            
            let title = model.withoutess ?? ""
            
            if title.isEmpty {
                typeLabel.isHidden = true
            }else {
                typeLabel.isHidden = false
            }
            
            typeLabel.text = title
            let backColor = model.finallyern ?? ""
            typeLabel.backgroundColor = UIColor.init(hexString: backColor)
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "plca_bg_image")
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
        twoLabel.font = UIFont.systemFont(ofSize: 24, weight: .black)
        return twoLabel
    }()
    
    lazy var typeLabel: PaddingLabel = {
        let typeLabel = PaddingLabel()
        typeLabel.textAlignment = .center
        typeLabel.textColor = .white
        typeLabel.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        typeLabel.layer.cornerRadius = 20
        typeLabel.layer.masksToBounds = true
        return typeLabel
    }()
    
    lazy var tapBtn: UIButton = {
        let tapBtn = UIButton(type: .custom)
        return tapBtn
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.size.equalTo(CGSize(width: 345.pix(), height: 128.pix()))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-12)
        }
        
        bgImageView.addSubview(logoImageView)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(oneLabel)
        bgImageView.addSubview(twoLabel)
        bgImageView.addSubview(typeLabel)
        
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(12.pix())
            make.left.equalToSuperview().offset(24.pix())
            make.width.height.equalTo(30.pix())
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalTo(logoImageView)
            make.left.equalTo(logoImageView.snp.right).offset(8)
            make.height.equalTo(20)
        }
        
        oneLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(22.pix())
            make.top.equalToSuperview().offset(66.pix())
            make.height.equalTo(15.pix())
        }
        
        twoLabel.snp.makeConstraints { make in
            make.left.equalTo(oneLabel)
            make.top.equalTo(oneLabel.snp.bottom).offset(5.pix())
            make.height.equalTo(24.pix())
        }
        
        typeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(68.pix())
            make.height.equalTo(40.pix())
            make.right.equalToSuperview().offset(-12)
        }
        
        contentView.addSubview(tapBtn)
        tapBtn.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        tapBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self, let model else { return }
                let productID = String(model.maciactuallyally ?? 0)
                self.tapBlock?(productID)
            })
            .disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
