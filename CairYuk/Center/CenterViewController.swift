//
//  CenterViewController.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/8.
//

import UIKit
import RxSwift
import SnapKit
import Combine
import MJRefresh

class CenterViewController: BaseViewController {
    
    lazy var centerView: CenterView = {
        let centerView = CenterView(frame: .zero)
        return centerView
    }()
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "app_head_bg_image")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.text = "Account".localized
        nameLabel.textColor = UIColor.white
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return nameLabel
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "#3F6EFF")
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(269.pix())
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(21)
        }
        
        view.addSubview(centerView)
        centerView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(19)
            make.left.right.bottom.equalToSuperview()
        }
        
        viewModel.$centerModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self, let model else { return }
                
                let securityair = model.securityair ?? ""
                
                if ["0", "00"].contains(securityair) {
                    let modelArray = model.fatherarium?.publicfic ?? []
                    self.centerView.modelArray = modelArray
                }
                self.centerView.tableView.reloadData()
                self.centerView.tableView.mj_header?.endRefreshing()
            }.store(in: &cancellables)
        
        viewModel.$centerMsg
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.centerView.tableView.mj_header?.endRefreshing()
            }.store(in: &cancellables)
        
        self.centerView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            getCenterInfo()
        })
        
        if let navigationController = self.navigationController {
            SchemeURLHandler.shared.configure(navigationController: navigationController)
        }
        
        centerView.tapBlock = { [weak self] pageUrl in
            guard let self = self else { return }
            if pageUrl.hasPrefix(Scheme_URL) {
                SchemeURLHandler.shared.handleURL(pageUrl)
            }else {
                self.goWebVc(pageUrl: pageUrl)
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCenterInfo()
    }
    
}

extension CenterViewController {
    
    private func getCenterInfo() {
        viewModel.centerInfo(parameters: [:])
    }
}
