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
