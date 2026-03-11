//
//  HomeViewController.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

import UIKit
import Combine
import DeviceKit
import SnapKit
import MJRefresh

class HomeViewController: BaseViewController {

    lazy var minView: HomeMinView = {
        let minView = HomeMinView(frame: .zero)
        minView.isHidden = true
        return minView
    }()
    
    lazy var maxView: HomeMaxView = {
        let maxView = HomeMaxView(frame: .zero)
        maxView.isHidden = true
        return maxView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "#3F6EFF")
        
        if let navigationController = self.navigationController {
            SchemeURLHandler.shared.configure(navigationController: navigationController)
        }
        
        viewModel.$homeModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self, let model else { return }
                
                let securityair = model.securityair ?? ""
                if ["0", "00"].contains(securityair) {
                    
                    let modelArray = model.fatherarium?.cordacity ?? []
                    
                    let listArray = modelArray.filter( { $0.donfold == "vulpice" } )
                    
                    let find = !listArray.isEmpty
                    
                    if find {
                        self.minView.isHidden = false
                        self.maxView.isHidden = true
                        self.minView.model = listArray.first?.foldfishess?.first
                    } else {
                        self.minView.isHidden = true
                        self.maxView.isHidden = false
                    }
                    
                }
                
                self.minView.scrollView.mj_header?.endRefreshing()
            }
            .store(in: &cancellables)
        
        viewModel.$homeMsg
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.minView.scrollView.mj_header?.endRefreshing()
            }
            .store(in: &cancellables)
        
        view.addSubview(minView)
        minView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        view.addSubview(maxView)
        maxView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        minView.tapBlock = { [weak self] productID in
            guard let self = self else { return }
            clickProduct(productID: productID)
        }
        
        self.minView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            getHomeInfo()
        })
        
        viewModel.$clickProductModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self, let model else { return }
                let securityair = model.securityair ?? ""
                if ["0", "00"].contains(securityair) {
                    let pageUrl = model.fatherarium?.botanitor ?? ""
                    if pageUrl.hasPrefix(Scheme_URL) {
                        SchemeURLHandler.shared.handleURL(pageUrl)
                    }else {
                        self.goWebVc(pageUrl: pageUrl)
                    }
                }
            }
            .store(in: &cancellables)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomeInfo()
    }
    
}

extension HomeViewController {
    
    private func getHomeInfo() {
        let parameters = ["hepatery": "1", "raucage": Device.identifier]
        viewModel.homeInfo(parameters: parameters)
    }
    
    private func clickProduct(productID: String) {
        
        if SecureUserManager.isLoggedIn() == false {
            self.popLoginVc()
            return
        }
        
        let parameters = ["theyhood": "1001",
                          "enjoyial": "1000",
                          "familitimeenne": "1000",
                          "dentacity": productID,
                          "decisionie": "1"]
        viewModel.clickProcutInfo(parameters: parameters)
    }
    
}

extension HomeViewController {
    
    private func popLoginVc() {
        let loginVc = LoginViewController()
        let navVc = BaseNavigationController(rootViewController: loginVc)
        navVc.modalPresentationStyle = .overFullScreen
        self.present(navVc, animated: true)
    }
    
}
