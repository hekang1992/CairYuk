//
//  BaseViewController.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/8.
//

import UIKit
import RxSwift
import Combine

class BaseViewController: UIViewController {
    
    let viewModel = AppViewModel()
    
    var cancellables = Set<AnyCancellable>()
    
    let disposeBag = DisposeBag()
    
    private var parameters: [String: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        viewModel.$applyOrderModel
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
                    
                    Task {
                        try? await Task.sleep(nanoseconds: 2_000_000_000)
                        
                        let productID = self.parameters["falcry"] ?? ""
                        
                        let OrderID = self.parameters["itudeacious"] ?? ""
                        
                        self.followInfo(step: "8",
                                        productID: productID,
                                        OrderID: OrderID,
                                        starttime: String(Int(Date().timeIntervalSince1970)),
                                        endtime: String(Int(Date().timeIntervalSince1970)))
                    }
                    
                }
            }
            .store(in: &cancellables)
        
    }
}

extension BaseViewController {
    
    func getFollowTime() -> String {
        return String(Int(Date().timeIntervalSince1970))
    }
}

extension BaseViewController {
    
    func goWebVc(pageUrl: String) {
        let h5Vc = H5ViewController()
        h5Vc.pageUrl = pageUrl
        self.navigationController?.pushViewController(h5Vc, animated: true)
    }
}

extension BaseViewController {
    
    func toProductListVc() {
        guard let nav = navigationController else { return }
        
        if let vc = nav.viewControllers.compactMap({ $0 as? ProductViewController }).first {
            nav.popToViewController(vc, animated: true)
        } else {
            nav.popToRootViewController(animated: true)
        }
    }
    
}

extension BaseViewController {
    
    func followInfo(step: String,
                    productID: String,
                    OrderID: String,
                    starttime: String,
                    endtime: String) {
        let parameters = ["actence": productID,
                          "colule": step,
                          "plec": OrderID,
                          "discuss": starttime,
                          "acetkin": endtime]
        viewModel.appFllowInfo(parameters: parameters)
    }
    
}

extension BaseViewController {
    
    func clickTypeToNextVc(stepModel: listensiveModel, cardModel: baloarianModel) {
        let type = stepModel.emeuous ?? ""
        
        switch type {
        case "exampleie":
            let completeVc = AuthCompleteViewController()
            completeVc.stepModel = stepModel
            completeVc.cardModel = cardModel
            self.navigationController?.pushViewController(completeVc, animated: true)
            
        case "zoain":
            let listVc = PersonalViewController()
            listVc.stepModel = stepModel
            listVc.cardModel = cardModel
            self.navigationController?.pushViewController(listVc, animated: true)
            
        case "noteable":
            let listVc = WorkViewController()
            listVc.stepModel = stepModel
            listVc.cardModel = cardModel
            self.navigationController?.pushViewController(listVc, animated: true)
            
        case "common":
            let listVc = ContactViewController()
            listVc.stepModel = stepModel
            listVc.cardModel = cardModel
            self.navigationController?.pushViewController(listVc, animated: true)
            
        case "major":
            let listVc = BankViewController()
            listVc.stepModel = stepModel
            listVc.cardModel = cardModel
            self.navigationController?.pushViewController(listVc, animated: true)
            
        case "":
            let parameters = ["itudeacious": cardModel.plec ?? "",
                              "falcry": cardModel.maciactuallyally ?? ""]
            self.parameters = parameters
            viewModel.applyOrderInfo(parameters: parameters)
            
        default:
            break
        }
        
    }
    
}
