//
//  HomeViewController.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

import UIKit
import Combine
import DeviceKit

class HomeViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        viewModel.$homeModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self, let model else { return }
            }
            .store(in: &cancellables)
        
        viewModel.$homeMsg
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
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
    
}
