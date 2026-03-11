//
//  AuthCompleteViewController.swift
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

class AuthCompleteViewController: BaseViewController {
    
    var cardModel: baloarianModel?
    
    var stepModel: listensiveModel? {
        didSet {
            guard let stepModel = stepModel else { return }
            headView.configTile(with: stepModel.participantarian ?? "")
        }
    }
    
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
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    lazy var headImageView: UIImageView = {
        let headImageView = UIImageView()
        headImageView.image = UIImage(named: "suc_en_fa_image".localized)
        headImageView.contentMode = .scaleAspectFit
        return headImageView
    }()
    
    lazy var cocView: UIView = {
        let cocView = UIView()
        cocView.layer.cornerRadius = 12
        cocView.layer.masksToBounds = true
        cocView.backgroundColor = UIColor.init(hexString: "#F8F9FB")
        return cocView
    }()
    
    lazy var oneView: CardListView = {
        let oneView = CardListView(frame: .zero)
        oneView.oneLabel.text = "Real name".localized
        return oneView
    }()
    
    lazy var twoView: CardListView = {
        let twoView = CardListView(frame: .zero)
        twoView.oneLabel.text = "PAN number".localized
        return twoView
    }()
    
    lazy var threeView: CardListView = {
        let threeView = CardListView(frame: .zero)
        threeView.oneLabel.text = "Date of birth".localized
        return threeView
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
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.toProductListVc()
        }
        
        bgView.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(nextBtn.snp.top).offset(-5.pix())
        }
        
        scrollView.addSubview(headImageView)
        headImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 336.pix(), height: 152.pix()))
        }
        
        scrollView.addSubview(cocView)
        cocView.snp.makeConstraints { make in
            make.top.equalTo(headImageView.snp.bottom).offset(22.pix())
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 343.pix(), height: 302.pix()))
            make.bottom.equalToSuperview().offset(-20.pix())
        }
        
        cocView.addSubview(oneView)
        cocView.addSubview(twoView)
        cocView.addSubview(threeView)
        
        oneView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.left.right.equalToSuperview()
            make.height.equalTo(76)
        }
        
        twoView.snp.makeConstraints { make in
            make.top.equalTo(oneView.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(76)
        }
        
        threeView.snp.makeConstraints { make in
            make.top.equalTo(twoView.snp.bottom).offset(16)
            make.left.right.equalToSuperview()
            make.height.equalTo(76)
        }
        
        viewModel.$authCardModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self, let model else { return }
                let securityair = model.securityair ?? ""
                if ["0", "00"].contains(securityair) {
                    if let listModel = model.fatherarium?.actionproof?.familianeity {
                        self.showUI(with: listModel)
                    }
                }
                self.scrollView.mj_header?.endRefreshing()
            }
            .store(in: &cancellables)
        
        viewModel.$authCardMsg
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                guard let self else { return }
                self.scrollView.mj_header?.endRefreshing()
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
                getDetailInfo()
            })
            .disposed(by: disposeBag)
        
        self.scrollView.mj_header = MJRefreshNormalHeader(refreshingBlock: { [weak self] in
            guard let self else { return }
            getCardInfo()
        })
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getCardInfo()
    }
    
}

extension AuthCompleteViewController {
    
    private func getDetailInfo() {
        let parameters = ["dentacity": cardModel?.maciactuallyally ?? ""]
        viewModel.procutDetailInfo(parameters: parameters)
    }
    
    private func getCardInfo() {
        let parameters = ["dentacity": cardModel?.maciactuallyally ?? ""]
        viewModel.authCardInfo(parameters: parameters)
    }
    
    private func showUI(with listModel: familianeityModel) {
        let name = listModel.traveleous ?? ""
        let number = listModel.lucmomentair ?? ""
        let time = listModel.spherdom ?? ""
        
        oneView.twoLabel.text = name
        twoView.twoLabel.text = number
        threeView.twoLabel.text = time
        
    }
    
}
