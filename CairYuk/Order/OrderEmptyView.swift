//
//  OrderEmptyView.swift
//  CairYuk
//
//  Created by hekang on 2026/3/10.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit

class OrderEmptyView: UIView {
    
    private let disposeBag = DisposeBag()
    
    var tapBlock: (() -> Void)?
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.setBackgroundImage(UIImage(named: "ccp_ien_image".localized), for: .normal)
        clickBtn.adjustsImageWhenHighlighted = false
        return clickBtn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(clickBtn)
        clickBtn.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 206.pix(), height: 276.pix()))
        }
        
        clickBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.tapBlock?()
            })
            .disposed(by: disposeBag)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

