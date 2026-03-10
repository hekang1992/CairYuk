//
//  OrderViewController.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

import UIKit
import RxSwift
import SnapKit
import Combine
import MJRefresh
import RxCocoa
import TYAlertController

class OrderViewController: BaseViewController {
    
    private let viewModel = AppViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    
    private var orderType: String = "4"
    
    private let titles = ["All".localized,
                          "In progress".localized,
                          "Repayment".localized,
                          "Finished".localized]
    
    private var buttons: [UIButton] = []
    
    private var selectedIndex: Int = 0 {
        didSet {
            updateButtonStates()
        }
    }
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "app_head_bg_image")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = UIColor.white
        nameLabel.text = "Orders".localized
        nameLabel.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        return nameLabel
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 8.pix()
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return bgView
    }()
    
    lazy var coverView: UIView = {
        let coverView = UIView()
        coverView.layer.cornerRadius = 24
        coverView.layer.masksToBounds = true
        coverView.backgroundColor = UIColor.init(hexString: "#F8F9FB")
        return coverView
    }()
    
    private lazy var indicatorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "secc_bg_image")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.estimatedRowHeight = 80
        tableView.delegate = self
        tableView.dataSource = self
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(OrderViewCell.self, forCellReuseIdentifier: "OrderViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "#3F6EFF")
        
        setupUI()
        setupButtons()
        setupConstraints()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [weak self] in
            self?.selectedIndex = 0
            self?.updateIndicatorPosition(animated: false)
        }
        
        viewModel.$orderListModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self, let model else { return }
                
            }
            .store(in: &cancellables)
        
    }
    
    private func setupUI() {
        view.addSubview(bgImageView)
        view.addSubview(nameLabel)
        view.addSubview(bgView)
        bgView.addSubview(coverView)
        coverView.addSubview(indicatorImageView)
        bgView.addSubview(tableView)
    }
    
    private func setupButtons() {
        for (index, title) in titles.enumerated() {
            let button = UIButton(type: .custom)
            button.setTitle(title, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
            
            button.setTitleColor(UIColor(hexString: "#99999B"), for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            button.setTitleColor(UIColor.black, for: .selected)
            
            button.translatesAutoresizingMaskIntoConstraints = false
            coverView.addSubview(button)
            buttons.append(button)
        }
    }
    
    private func setupConstraints() {
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(269.pix())
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.equalToSuperview().offset(20)
            make.height.equalTo(44.pix())
        }
        
        bgView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(5.pix())
            make.left.right.bottom.equalToSuperview()
        }
        
        coverView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(12)
            make.centerX.equalToSuperview()
            make.height.equalTo(48)
        }
        
        for (index, button) in buttons.enumerated() {
            button.snp.makeConstraints { make in
                make.centerY.equalToSuperview()
                make.height.equalTo(44)
                
                switch index {
                case 0:
                    make.left.equalToSuperview().offset(12)
                    
                case 1:
                    make.left.equalTo(buttons[0].snp.right).offset(20)
                    
                case 2:
                    make.left.equalTo(buttons[1].snp.right).offset(30)
                    
                case 3:
                    make.left.equalTo(buttons[2].snp.right).offset(20)
                    make.right.lessThanOrEqualToSuperview().offset(-12)
                    
                default:
                    break
                }
            }
            
            button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 4, bottom: 0, right: 4)
        }
        
        indicatorImageView.snp.makeConstraints { make in
            make.bottom.equalTo(coverView.snp.bottom).offset(-4)
            make.centerX.equalTo(buttons[0].snp.centerX)
            make.size.equalTo(CGSize(width: 15, height: 7))
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(coverView.snp.bottom).offset(5)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    @objc private func buttonTapped(_ sender: UIButton) {
        let index = sender.tag
        selectedIndex = index
        switch selectedIndex {
        case 0:
            orderType = "4"
            
        case 1:
            orderType = "7"
            
        case 2:
            orderType = "6"
            
        case 3:
            orderType = "5"
            
        default:
            break
        }
        orderListInfo(type: orderType)
        updateIndicatorPosition(animated: true)
    }
    
    private func updateButtonStates() {
        for (index, button) in buttons.enumerated() {
            if index == selectedIndex {
                button.setTitleColor(UIColor.black, for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .bold)
                button.isSelected = true
            } else {
                button.setTitleColor(UIColor(hexString: "#99999B"), for: .normal)
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
                button.isSelected = false
            }
        }
    }
    
    private func updateIndicatorPosition(animated: Bool) {
        guard selectedIndex < buttons.count else { return }
        
        let selectedButton = buttons[selectedIndex]
        
        if animated {
            UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut) { [weak self] in
                self?.indicatorImageView.snp.remakeConstraints { make in
                    make.bottom.equalTo(self?.coverView.snp.bottom ?? 0).offset(-4)
                    make.centerX.equalTo(selectedButton.snp.centerX)
                    make.size.equalTo(CGSize(width: 15, height: 7))
                }
                self?.coverView.layoutIfNeeded()
            }
        } else {
            indicatorImageView.snp.remakeConstraints { make in
                make.bottom.equalTo(coverView.snp.bottom).offset(-4)
                make.centerX.equalTo(selectedButton.snp.centerX)
                make.size.equalTo(CGSize(width: 15, height: 7))
            }
            coverView.layoutIfNeeded()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        orderListInfo(type: orderType)
    }
}

extension OrderViewController {
    
    private func orderListInfo(type: String) {
        let parameters = ["spherery": type, "habitkin": "1", "shakeeous": "100"]
        viewModel.orderListlInfo(parameters: parameters)
    }
    
}

extension OrderViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderViewCell", for: indexPath) as! OrderViewCell
        cell.textLabel?.text = "\(indexPath.row)========"
        return cell
    }
    
}
