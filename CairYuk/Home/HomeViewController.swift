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
    
    private let viewModel = AppViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
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
        
        viewModel.$homeModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self, let model else { return }
                
                let securityair = model.securityair ?? ""
                ToastManager.showOnWindow(model.northature ?? "")
                if ["0", "00"].contains(securityair) {
                    
                    let modelArray = model.fatherarium?.cordacity ?? []
                    
                    let find = !modelArray.filter({ $0.donfold == "vulpice" }).isEmpty
                    
                    if find {
                        self.minView.isHidden = false
                        self.maxView.isHidden = true
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
        
        self.minView.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self = self else { return }
            getHomeInfo()
        })
        
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
    
}
