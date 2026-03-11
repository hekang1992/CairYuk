//
//  HomeCardViewCell.swift
//  CairYuk
//
//  Created by hekang on 2026/3/11.
//

import UIKit
import SnapKit

class HomeCardViewCell: UITableViewCell {
    
    var model: foldfishessModel? {
        didSet {
            guard let model = model else { return }
            cardView.model = model
        }
    }
    
    lazy var cardView: HomeCardView = {
        let cardView = HomeCardView(frame: .zero)
        return cardView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        selectionStyle = .none
        contentView.addSubview(cardView)
        cardView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(45.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 375.pix(), height: 255.pix()))
            make.bottom.equalToSuperview().offset(-16.pix())
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
