//
//  HomeMinView.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/9.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HomeMinView: UIView {
    
    var model: foldfishessModel? {
        didSet {
            guard let model = model else { return }
            cardView.model = model
        }
    }
    
    private let disposeBag = DisposeBag()
    
    var tapBlock: ((String) -> Void)?
    
    var tapMentBlock: ((String) -> Void)?

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
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hexString: "#F8F9FB")
        return bgView
    }()
    
    lazy var cardView: HomeCardView = {
        let cardView = HomeCardView(frame: .zero)
        return cardView
    }()
    
    lazy var policyBtn: UIButton = {
        let policyBtn = UIButton(type: .custom)
        policyBtn.setBackgroundImage(UIImage(named: "en_policy_image"), for: .normal)
        return policyBtn
    }()
    
    lazy var threeImageView: UIImageView = {
        let threeImageView = UIImageView()
        threeImageView.image = UIImage(named: "en_step_image".localized)
        threeImageView.contentMode = .scaleAspectFit
        return threeImageView
    }()
    
    lazy var fourImageView: UIImageView = {
        let fourImageView = UIImageView()
        fourImageView.image = UIImage(named: "en_fstep_image")
        fourImageView.contentMode = .scaleAspectFit
        return fourImageView
    }()
    
    lazy var fiveImageView: UIImageView = {
        let fiveImageView = UIImageView()
        fiveImageView.image = UIImage(named: "en_fivstep_image")
        fiveImageView.contentMode = .scaleAspectFit
        return fiveImageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bgView)
        
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(269.pix())
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(240.pix())
            make.left.right.bottom.equalToSuperview()
        }
        
        addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
        
        scrollView.addSubview(oneImageView)
        scrollView.addSubview(twoImageView)
        scrollView.addSubview(cardView)
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
        cardView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(twoImageView.snp.bottom).offset(-110.pix())
            make.size.equalTo(CGSize(width: 375.pix(), height: 255.pix()))
        }
        
        if LanguageManager.shared.currentType == .english {
            scrollView.addSubview(policyBtn)
            scrollView.addSubview(threeImageView)
            scrollView.addSubview(fourImageView)
            scrollView.addSubview(fiveImageView)
            
            policyBtn.snp.makeConstraints { make in
                make.centerX.equalToSuperview()
                make.top.equalTo(cardView.snp.bottom).offset(16)
                make.size.equalTo(CGSize(width: 343.pix(), height: 48.pix()))
            }
            
            threeImageView.snp.makeConstraints { make in
                make.top.equalTo(policyBtn.snp.bottom).offset(16)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 343.pix(), height: 186.pix()))
            }
            
            fourImageView.snp.makeConstraints { make in
                make.top.equalTo(threeImageView.snp.bottom).offset(16)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 343.pix(), height: 234.pix()))
            }
            
            fiveImageView.snp.makeConstraints { make in
                make.top.equalTo(fourImageView.snp.bottom).offset(16)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 343.pix(), height: 120.pix()))
                make.bottom.equalToSuperview().offset(-20.pix())
            }
            
            policyBtn.rx.tap.bind(onNext: { [weak self] in
                self?.tapMentBlock?("/pressurefication")
            }).disposed(by: disposeBag)
            
        }else {
            scrollView.addSubview(threeImageView)
            
            threeImageView.snp.makeConstraints { make in
                make.top.equalTo(cardView.snp.bottom).offset(16)
                make.centerX.equalToSuperview()
                make.size.equalTo(CGSize(width: 343.pix(), height: 186.pix()))
                make.bottom.equalToSuperview().offset(-20.pix())
            }
        }
        
        cardView.tapBlock = { [weak self] productID in
            guard let self = self else { return }
            self.tapBlock?(productID)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeMinView {
    
    
    
}
