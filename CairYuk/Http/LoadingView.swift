//
//  LoadingView.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

import UIKit
import SnapKit

final class LoadingView {
    
    static let shared = LoadingView()
    
    private var backgroundView: UIView?
    
    private init() {}
        
    func show() {
        
        guard backgroundView == nil else { return }
        
        guard let window = UIApplication.shared
            .connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .first?
            .windows
            .first(where: { $0.isKeyWindow })
        else { return }
        
        let bgView = UIView()
        bgView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        
        window.addSubview(bgView)
        
        bgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let container = UIView()
        container.backgroundColor = .white
        container.layer.cornerRadius = 12
        
        bgView.addSubview(container)
        
        container.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(CGSize(width: 120, height: 120))
        }
        
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.startAnimating()
        
        container.addSubview(indicator)
        
        indicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        backgroundView = bgView
    }
    
    func hide() {
        
        DispatchQueue.main.async {
            self.backgroundView?.removeFromSuperview()
            self.backgroundView = nil
        }
    }
}
