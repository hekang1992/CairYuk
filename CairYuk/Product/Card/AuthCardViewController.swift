//
//  AuthCardViewController.swift
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

class AuthCardViewController: BaseViewController {
    
    private var onetime: String = ""
    
    private var twotime: String = ""
    
    private var cameraManager: CameraManager?
    
    private let location = AppLocationManager()
    
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
        headImageView.image = UIImage(named: "in_one_icon_image")
        headImageView.contentMode = .scaleAspectFit
        return headImageView
    }()
    
    lazy var clickBtn: UIButton = {
        let clickBtn = UIButton(type: .custom)
        clickBtn.setBackgroundImage(UIImage(named: "front_card_en_image".localized), for: .normal)
        clickBtn.adjustsImageWhenHighlighted = false
        return clickBtn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.init(hexString: "#3F6EFF")
        
        location.startLocation { result, error in }
        
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
        
        bgView.addSubview(scrollView)
        scrollView.addSubview(headImageView)
        scrollView.addSubview(clickBtn)
        
        scrollView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(nextBtn.snp.top).offset(-5)
        }
        
        headImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
            make.size.equalTo(CGSize(width: 350.pix(), height: 54.pix()))
        }
        
        clickBtn.snp.makeConstraints { make in
            make.top.equalTo(headImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
            make.size.equalTo(CGSize(width: 327.pix(), height: 405.pix()))
            make.bottom.equalToSuperview().offset(-20.pix())
        }
        
        headView.backBlock = { [weak self] in
            guard let self = self else { return }
            self.popLeaveView()
        }
        
        clickBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                cameraManager?.openCamera()
            })
            .disposed(by: disposeBag)
        
        nextBtn
            .rx
            .tap
            .throttle(.microseconds(250), scheduler: MainScheduler.instance)
            .bind(onNext: { [weak self] in
                guard let self = self else { return }
                cameraManager?.openCamera()
            })
            .disposed(by: disposeBag)
        
        cameraManager = CameraManager(
            presentingViewController: self,
            initialCameraPosition: .rear
        )
        
        cameraManager?.photoCaptureComplete = { [weak self] image in
            if let self, let image {
                self.uploadImageInfo(image: image)
            }
        }
        
        viewModel.$uploadFrontCardModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self, let model else { return }
                let securityair = model.securityair ?? ""
                if ["0", "00"].contains(securityair) {
                    let wayine = model.fatherarium?.wayine ?? 1
                    if wayine == 0 {
                        
                        Task {
                            try? await Task.sleep(nanoseconds: 2_000_000_000)
                            let productID = self.cardModel?.maciactuallyally ?? ""
                            let OrderID = self.cardModel?.plec ?? ""
                            self.followInfo(step: "2",
                                            productID: productID,
                                            OrderID: OrderID,
                                            starttime: self.onetime,
                                            endtime: self.twotime)
                        }
                        
                        let faceVc = AuthFaceViewController()
                        faceVc.stepModel = stepModel
                        faceVc.cardModel = cardModel
                        self.navigationController?.pushViewController(faceVc, animated: true)
                    }else {
                        let popView = PopAuthCardView(frame: self.view.bounds)
                        let alertVc = TYAlertController(alert: popView, preferredStyle: .actionSheet)
                        if let fatherariumModel = model.fatherarium {
                            popView.model = fatherariumModel
                        }
                        self.present(alertVc!, animated: true)
                        
                        popView.cancelBlock = { [weak self] in
                            self?.dismiss(animated: true)
                        }
                        
                        popView.sureBlock = { [weak self] name, number, time in
                            guard let self = self else { return }
                            
                            if name.isEmpty {
                                ToastManager.showOnWindow("Please enter your name".localized)
                                return
                            }
                            
                            if number.isEmpty {
                                ToastManager.showOnWindow("Please enter your ID number".localized)
                                return
                            }
                            
                            if time.isEmpty {
                                ToastManager.showOnWindow("Please enter your birthday".localized)
                                return
                            }
                            
                            let parameters = ["traveleous": name,
                                              "lucmomentair": number,
                                              "spherdom": time,
                                              "visitmost": SecureUserManager.getPhone() ?? "",
                                              "dentacity": cardModel?.maciactuallyally ?? "",
                                              "itudeacious": cardModel?.withoutess ?? ""]
                            
                            viewModel.saveCardInfo(parameters: parameters)
                            
                        }
                        
                    }
                }else {
                    ToastManager.showOnWindow(model.northature ?? "")
                }
            }
            .store(in: &cancellables)
        
        viewModel.$saveCardModel
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self, let model else { return }
                let securityair = model.securityair ?? ""
                if ["0", "00"].contains(securityair) {
                    
                    Task {
                        try? await Task.sleep(nanoseconds: 2_000_000_000)
                        let productID = self.cardModel?.maciactuallyally ?? ""
                        let OrderID = self.cardModel?.plec ?? ""
                        self.followInfo(step: "2",
                                        productID: productID,
                                        OrderID: OrderID,
                                        starttime: self.onetime,
                                        endtime: self.twotime)
                    }
                    
                    self.dismiss(animated: true) {
                        let faceVc = AuthFaceViewController()
                        faceVc.stepModel = self.stepModel
                        faceVc.cardModel = self.cardModel
                        self.navigationController?.pushViewController(faceVc, animated: true)
                    }
                }else {
                    ToastManager.showOnWindow(model.northature ?? "")
                }
            }.store(in: &cancellables)
        
        onetime = self.getFollowTime()
        
    }
    
}

extension AuthCardViewController {
    
    private func uploadImageInfo(image: UIImage) {
        twotime = self.getFollowTime()
        let parameters = ["donfold": "11",
                          "lenade": "2",
                          "nuncicanitude": "",
                          "trudaceous": "1"]
        viewModel.uploadFrontCardInfo(parameters: parameters, images: [image])
    }
    
}
