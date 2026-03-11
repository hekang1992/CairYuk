//
//  OneViewCell.swift
//  CairYuk
//
//  Created by hekang on 2026/3/10.
//

import UIKit
import SnapKit

class OneViewCell: UITableViewCell {
    
    var textChanged: ((String)->Void)?
    
    var model: ambrememberuousModel? {
        didSet {
            guard let model = model else { return }
            oneLabel.text = model.participantarian ?? ""
            oneTextFiled.placeholder = model.spargenne ?? ""
            
            let soundfy = model.soundfy ?? ""
            oneTextFiled.keyboardType = soundfy == "1" ? .numberPad : .default
            
            let selectName = model.amify ?? ""
            oneTextFiled.text = selectName
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
        return oneTextFiled
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        selectionStyle = .none
        
        contentView.addSubview(oneLabel)
        contentView.addSubview(oneView)
        oneView.addSubview(oneTextFiled)
        
        oneTextFiled.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        
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
        
        oneTextFiled.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(15.pix())
            make.right.equalToSuperview().offset(-5.pix())
        }
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        let text = textField.text ?? ""
        textChanged?(text)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
