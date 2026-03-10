//
//  ClickCellAlertView.swift
//  CairYuk
//
//  Created by hekang on 2026/3/10.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class ClickCellAlertView: UIView {
    
    var cancelBlock: (() -> Void)?
    
    var saveBlock: ((petrsiveModel) -> Void)?
    
    private var currentSelectedIndex: Int? = nil
    
    private let disposeBag = DisposeBag()
    
    var modelArray: [petrsiveModel]?
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "ncp_a_d_image")
        bgImageView.isUserInteractionEnabled = true
        return bgImageView
    }()
    
    lazy var cancelBtn: UIButton = {
        let cancelBtn = UIButton(type: .custom)
        return cancelBtn
    }()
    
    lazy var nameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.textAlignment = .left
        nameLabel.textColor = .black
        nameLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        return nameLabel
    }()
    
    lazy var confirmBtn: UIButton = {
        let confirmBtn = UIButton(type: .custom)
        confirmBtn.setTitle("Confirm".localized, for: .normal)
        confirmBtn.setTitleColor(UIColor.white, for: .normal)
        confirmBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        confirmBtn.setBackgroundImage(UIImage(named: "con_a_bt_image"), for: .normal)
        confirmBtn.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 10, right: 0)
        return confirmBtn
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
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.layer.cornerRadius = 16
        tableView.layer.masksToBounds = true
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(bgImageView)
        bgImageView.addSubview(cancelBtn)
        bgImageView.addSubview(nameLabel)
        bgImageView.addSubview(confirmBtn)
        bgImageView.addSubview(tableView)
        
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
            make.bottom.equalTo(cancelBtn.snp.top).offset(-32.pix())
            make.centerX.equalToSuperview()
            make.width.equalTo(261.pix())
            make.height.equalTo(65.pix())
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(20.pix())
            make.left.right.equalToSuperview()
            make.bottom.equalTo(confirmBtn.snp.top).offset(-5.pix())
        }
        
        cancelBtn.rx.tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                self?.cancelBlock?()
            })
            .disposed(by: disposeBag)
        
        confirmBtn
            .rx
            .tap
            .throttle(.milliseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                if currentSelectedIndex == nil {
                    ToastManager.showOnWindow("Please select one item".localized)
                    return
                }
                if let modelArray = modelArray, let currentSelectedIndex = currentSelectedIndex {
                    self.saveBlock?(modelArray[currentSelectedIndex])
                }
            })
            .disposed(by: disposeBag)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func selectIndex(_ index: Int?) {
        guard let modelArray = modelArray, modelArray.count > 0 else { return }
        
        if let index = index, index >= 0 && index < modelArray.count {
            currentSelectedIndex = index
        } else {
            currentSelectedIndex = nil
        }
        
        tableView.reloadData()
    }
    
}

extension ClickCellAlertView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 12.pix()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.modelArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        
        cell.contentView.backgroundColor = .clear
        
        let model = self.modelArray?[indexPath.row]
        
        cell.textLabel?.text = model?.traveleous ?? ""
        
        cell.textLabel?.textAlignment = .center
        
        let isSelected = (currentSelectedIndex == indexPath.row)
        
        cell.backgroundColor = isSelected ? UIColor.init(hexString: "#3F6EFF") : UIColor.white
        
        cell.layer.cornerRadius = 12
        cell.layer.masksToBounds = true
        
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
    
}
