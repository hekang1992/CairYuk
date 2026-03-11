//
//  HomeViewController.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/8.
//

import UIKit
import Combine
import DeviceKit
import SnapKit
import MJRefresh
import AdSupport
import AppTrackingTransparency

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
    
    private let location = AppLocationManager()
    
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
                        self.maxView.modelArray = modelArray
                        self.maxView.tableView.reloadData()
                    }
                    
                }
                self.maxView.tableView.mj_header?.endRefreshing()
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
        
        self.maxView.tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
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
                }else {
                    ToastManager.showOnWindow(model.northature ?? "")
                }
            }
            .store(in: &cancellables)
        
        maxView.tapBlock = { [weak self] productID in
            guard let self else { return }
            clickProduct(productID: productID)
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getHomeInfo()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Task {
            await self.getIDFA()
        }
    }
    
}

extension HomeViewController {
    
    private func getIDFA() async {
        guard #available(iOS 14, *) else { return }
        
        try? await Task.sleep(nanoseconds: 800_000_000)
        let status = await ATTrackingManager.requestTrackingAuthorization()
        
        print("Tracking authorization status: \(status.rawValue)")
    }
    
    private func showLocationAlertInfo() {
        let alert = UIAlertController(
            title: "需要开启定位权限",
            message: "请前往设置开启定位",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "取消", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "去设置", style: .default) { _ in
            
            if let url = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(url)
            }
            
        })
        
        present(alert, animated: true)
    }
    
}

extension HomeViewController {
    
    private func getHomeInfo() {
        let parameters = ["hepatery": "1", "raucage": Device.identifier]
        viewModel.homeInfo(parameters: parameters)
        
        if SecureUserManager.isLoggedIn() {
            location.startLocation { [weak self] result, error in
                guard let self else { return }
                if result.isEmpty {
                    if LanguageManager.shared.currentType == .indonesian {
                        if location.shouldShowLocationAlert() {
                            self.showLocationAlertInfo()
                        }
                    }
                }else {
                    viewModel.uploadLocationInfo(parameters: result)
                }
            }
            
            UIDevice.current.buildDeviceInfo { [weak self] dict in
                guard let self else { return }
                if let data = try? JSONSerialization.data(withJSONObject: dict),
                   let base64 = data.base64EncodedString() as String? {
                    let parameters = ["fatherarium": base64]
                    viewModel.uploadAppMessageInfo(parameters: parameters)
                }
            }
            
        }
        
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
