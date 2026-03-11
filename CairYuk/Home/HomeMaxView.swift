//
//  HomeMaxView.swift
//  CairYuk
//
//  Created by hekang on 2026/3/9.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class HomeMaxView: UIView {
    
    var modelArray: [cordacityModel] = []
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "app_head_bg_image")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    lazy var oneImageView: UIImageView = {
        let oneImageView = UIImageView()
        oneImageView.image = UIImage(named: "home_ec_two_image")
        oneImageView.contentMode = .scaleAspectFit
        return oneImageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(HomeCardViewCell.self, forCellReuseIdentifier: "HomeCardViewCell")
        tableView.register(HomeBannerViewCell.self, forCellReuseIdentifier: "HomeBannerViewCell")
        tableView.register(HomeProductViewCell.self, forCellReuseIdentifier: "HomeProductViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = UIColor.init(hexString: "#F8F9FB")
        return bgView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(269.pix())
        }
        
        addSubview(oneImageView)
        oneImageView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).offset(-40)
            make.size.equalTo(CGSize(width: 375.pix(), height: 193.pix()))
            make.centerX.equalToSuperview()
        }
        
        addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalTo(oneImageView.snp.bottom).offset(-20)
            make.left.right.bottom.equalToSuperview()
        }
        
        addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.right.bottom.equalToSuperview()
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension HomeMaxView: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.modelArray.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let model = self.modelArray[section]
        let type = model.donfold ?? ""
        
        switch type {
        case "prin":
            return 0
            
        case "taur", "genarwrongitude":
            return 1
            
        case "billion":
            return model.foldfishess?.count ?? 0
            
        default:
            return 0
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let model = self.modelArray[indexPath.section]
        
        let type = model.donfold ?? ""
        
        switch type {
        case "prin":
            return UITableViewCell()
            
        case "genarwrongitude":
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeBannerViewCell", for: indexPath) as! HomeBannerViewCell
            return cell
            
        case "taur":
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCardViewCell", for: indexPath) as! HomeCardViewCell
            cell.model = model.foldfishess?.first
            return cell
            
        case "billion":
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeProductViewCell", for: indexPath) as! HomeProductViewCell
            return cell
            
        default:
            return UITableViewCell()
        }
        
    }
    
}
