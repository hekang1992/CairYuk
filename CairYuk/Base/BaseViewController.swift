//
//  BaseViewController.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

import UIKit
import RxSwift

class BaseViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .white
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
    
    func clickTypeToNextVc(stepModel: listensiveModel, cardModel: baloarianModel) {
        let type = stepModel.emeuous ?? ""
        
        switch type {
        case "exampleie":
            break
            
        case "zoain":
            break
            
        case "noteable":
            break
            
        case "common":
            break
            
        case "major":
            break
            
        case "":
            break
            
        default:
            break
        }
        
    }
    
}
