//
//  ClickCellAlertView.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/10.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ClickCellAlertView: UIView {
    
    // MARK: - Public Properties
    var cancelBlock: (() -> Void)?
    var saveBlock: ((petrsiveModel) -> Void)?
    
    // MARK: - Private Properties
    private var currentSelectedIndex: Int?
    private let disposeBag = DisposeBag()
    var modelArray: [petrsiveModel]?
    
    // MARK: - UI Components
    private lazy var bgImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ncp_a_d_image")
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    private lazy var cancelBtn: UIButton = {
        let button = UIButton(type: .custom)
        return button
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return label
    }()
    
    private lazy var confirmBtn: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Confirm".localized, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        button.setBackgroundImage(UIImage(named: "con_a_bt_image"), for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 12.pix(), right: 0)
        return button
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(BlueViewCell.self, forCellReuseIdentifier: BlueViewCell.identifier)
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupBindings()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Public Methods
    func configure(with models: [petrsiveModel]?, selectedIndex: Int? = nil) {
        self.modelArray = models
        self.currentSelectedIndex = selectedIndex
        tableView.reloadData()
    }
    
    func selectIndex(_ index: Int?) {
        guard let models = modelArray, !models.isEmpty else { return }
        
        if let index = index, index >= 0 && index < models.count {
            currentSelectedIndex = index
        } else {
            currentSelectedIndex = nil
        }
        
        tableView.reloadData()
    }
    
    // MARK: - Private Methods
    private func setupUI() {
        addSubview(bgImageView)
        bgImageView.addSubview(cancelBtn)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(confirmBtn)
        bgImageView.addSubview(tableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        bgImageView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 537.pix()))
        }
        
        cancelBtn.snp.makeConstraints { make in
            make.width.height.equalTo(32.pix())
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(49.pix())
            make.left.equalToSuperview().offset(16)
            make.height.equalTo(20)
        }
        
        confirmBtn.snp.makeConstraints { make in
            make.bottom.equalTo(cancelBtn.snp.top).offset(-35.pix())
            make.centerX.equalToSuperview()
            make.width.equalTo(261.pix())
            make.height.equalTo(65.pix())
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20.pix())
            make.left.right.equalToSuperview()
            make.bottom.equalTo(confirmBtn.snp.top).offset(-5.pix())
        }
    }
    
    private func setupBindings() {
        cancelBtn.rx.tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                self?.cancelBlock?()
            })
            .disposed(by: disposeBag)
        
        confirmBtn.rx.tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                self?.handleConfirmTap()
            })
            .disposed(by: disposeBag)
    }
    
    private func handleConfirmTap() {
        guard let selectedIndex = currentSelectedIndex else {
            ToastManager.showOnWindow("Please select one item".localized)
            return
        }
        
        guard let models = modelArray, selectedIndex < models.count else { return }
        
        saveBlock?(models[selectedIndex])
    }
    
    private func configureCell(_ cell: BlueViewCell, at indexPath: IndexPath) {
        guard let model = modelArray?[indexPath.row] else { return }
        
        cell.nameLabel.text = model.traveleous
        
        let isSelected = (currentSelectedIndex == indexPath.row)
        
        cell.bgView.backgroundColor = isSelected ? UIColor(hexString: "#3F6EFF") : .white
        cell.nameLabel.font = isSelected ?
        UIFont.systemFont(ofSize: 15, weight: .bold) :
        UIFont.systemFont(ofSize: 15, weight: .medium)
        cell.nameLabel.textColor = isSelected ? .white : .black
    }
}

// MARK: - UITableViewDataSource & UITableViewDelegate
extension ClickCellAlertView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: BlueViewCell.identifier, for: indexPath) as! BlueViewCell
        configureCell(cell, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if currentSelectedIndex == indexPath.row {
            currentSelectedIndex = nil
        } else {
            currentSelectedIndex = indexPath.row
        }
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20.pix()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
}

// MARK: - Reusable Identifier Extension
extension BlueViewCell {
    static let identifier = "BlueViewCell"
}
