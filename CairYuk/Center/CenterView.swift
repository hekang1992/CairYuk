//
//  CenterView.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/9.
//

import UIKit
import SnapKit

class CenterView: UIView {
    
    var tapBlock: ((String) -> Void)?
    
    var modelArray: [publicficModel] = []
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 8.pix()
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return bgView
    }()
    
    lazy var iconImageView: UIImageView = {
        let iconImageView = UIImageView()
        iconImageView.image = UIImage(named: "cin_icon_image")
        return iconImageView
    }()
    
    lazy var phoneLabel: UILabel = {
        let phoneLabel = UILabel()
        phoneLabel.textAlignment = .left
        phoneLabel.text = phoneFormat(SecureUserManager.getPhone() ?? "")
        phoneLabel.textColor = UIColor.black
        phoneLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        return phoneLabel
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(CenterViewCell.self, forCellReuseIdentifier: "CenterViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgView)
        bgView.addSubview(iconImageView)
        bgView.addSubview(phoneLabel)
        bgView.addSubview(tableView)
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        iconImageView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(24)
            make.width.height.equalTo(50)
        }
        phoneLabel.snp.makeConstraints { make in
            make.centerY.equalTo(iconImageView)
            make.left.equalTo(iconImageView.snp.right).offset(12)
            make.height.equalTo(20)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(iconImageView.snp.bottom).offset(20)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension CenterView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "cic_en_image".localized)
        headView.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(10.pix())
            make.size.equalTo(CGSize(width: 343.pix(), height: 120.pix()))
        }
        return headView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150.pix()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CenterViewCell", for: indexPath) as! CenterViewCell
        let model = self.modelArray[indexPath.row]
        cell.model = model
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.modelArray[indexPath.row]
        let pageUrl = model.technivity ?? ""
        self.tapBlock?(pageUrl)
    }
    
}

extension CenterView {
    
    func phoneFormat(_ phoneNumber: String,
                prefixLength: Int = 3,
                suffixLength: Int = 4) -> String {
        let count = phoneNumber.count
        
        guard count >= prefixLength + suffixLength else {
            return phoneNumber
        }
        
        let prefix = String(phoneNumber.prefix(prefixLength))
        let suffix = String(phoneNumber.suffix(suffixLength))
        let hiddenCount = count - prefixLength - suffixLength
        
        return prefix + String(repeating: "*", count: hiddenCount) + suffix
    }
    
}
