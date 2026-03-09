//
//  HomeMinView.swift
//  CairYuk
//
//  Created by hekang on 2026/3/9.
//

import UIKit
import SnapKit

class HomeMinView: UIView {

    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        scrollView.contentInsetAdjustmentBehavior = .never
        return scrollView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "app_head_bg_image")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "home_en_one_image".localized)
        oneImageView.contentMode = .scaleAspectFit
        return oneImageView
    }()
    
    lazy var twoImageView: UIImageView = {
        let twoImageView = UIImageView()
        twoImageView.image = UIImage(named: "home_ec_two_image")
        twoImageView.contentMode = .scaleAspectFit
        return twoImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(269.pix())
        }
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(oneImageView)
        scrollView.addSubview(twoImageView)
        oneImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5.pix())
            make.left.equalToSuperview().offset(20.pix())
            if LanguageManager.shared.currentType == .indonesian {
                make.size.equalTo(CGSize(width: 336.pix(), height: 112.pix()))
            }else {
                make.size.equalTo(CGSize(width: 341.pix(), height: 102.pix()))
            }
        }
        twoImageView.snp.makeConstraints { make in
            make.top.equalTo(oneImageView.snp.bottom).offset(-50.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix(), height: 193.pix()))
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
