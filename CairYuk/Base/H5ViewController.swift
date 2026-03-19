//
//  H5ViewController.swift
//  CairYuk
//
//  Created by David Jones on 2026/3/9.
//

import UIKit
import WebKit
import RxSwift
import RxCocoa
import SnapKit
import StoreKit

class H5ViewController: BaseViewController {
    
    var pageUrl: String = ""
    
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
    
    lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        
        let contentController = WKUserContentController()
        
        contentController.add(self, name: "stratally")
        contentController.add(self, name: "front")
        contentController.add(self, name: "populfy")
        contentController.add(self, name: "behindality")
        contentController.add(self, name: "limincollectionial")
        contentController.add(self, name: "tersTVo")
        
        configuration.userContentController = contentController
        
        let webView = WKWebView(frame: .zero, configuration: configuration)
        webView.backgroundColor = .white
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }()
    
    lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.progressTintColor = UIColor(hexString: "#3F6EFF")
        progressView.trackTintColor = .lightGray
        progressView.isHidden = true
        return progressView
    }()
    
    private let location = AppLocationManager()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hexString: "#3F6EFF")
        
        setupUI()
        bindWebView()
        loadWebView()
        
        headView.backBlock = { [weak self] in
            guard let self else { return }
            if self.webView.canGoBack {
                self.webView.goBack()
            }else {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    private func setupUI() {
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
            make.top.equalTo(headView.snp.bottom)
            make.left.right.bottom.equalToSuperview()
        }
        
        bgView.addSubview(webView)
        webView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        bgView.addSubview(progressView)
        progressView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(2)
        }
    }
    
    // MARK: - RxSwift Binding
    private func bindWebView() {
        webView.rx.observeWeakly(Double.self, "estimatedProgress")
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] progress in
                guard let self = self, let progress = progress else { return }
                let progressFloat = Float(progress)
                
                self.progressView.isHidden = false
                self.progressView.setProgress(progressFloat, animated: true)
                
                if progressFloat >= 1.0 {
                    UIView.animate(withDuration: 0.3, animations: {
                        self.progressView.alpha = 0
                    }, completion: { _ in
                        self.progressView.isHidden = true
                        self.progressView.alpha = 1
                        self.progressView.setProgress(0, animated: false)
                    })
                }
            })
            .disposed(by: disposeBag)
        
        webView.rx.observeWeakly(String.self, "title")
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] title in
                guard let self = self, let title = title else { return }
                self.headView.configTile(with: title)
            })
            .disposed(by: disposeBag)
        
    }
    
    private func loadWebView() {
        guard let url = self.createRequestUrl(baseUrl: pageUrl) else { return }
        let request = URLRequest(url: url)
        webView.load(request)
    }
    
    private func handleH5Call(methodName: String, body: Any?) {
        switch methodName {
        case "stratally":
            
            location.startLocation { result, error in }
            
            let listArray = body as? [String] ?? []
            let productID = listArray.first ?? ""
            let orderID = listArray.last ?? ""
            let time = String(Int(Date().timeIntervalSince1970))
            
            Task {
                try? await Task.sleep(nanoseconds: 2_000_000_000)
                
                self.followInfo(step: "9",
                                productID: productID,
                                OrderID: orderID,
                                starttime: time,
                                endtime: time)
            }
            
        case "front":
            guard let pageUrl = body as? String, !pageUrl.isEmpty else {
                return
            }
            
            if pageUrl.hasPrefix(Scheme_URL) {
                SchemeURLHandler.shared.handleURL(pageUrl, from: self)
            }else {
                self.pageUrl = pageUrl
                self.loadWebView()
            }
            
        case "populfy":
            self.navigationController?.popViewController(animated: true)
            
        case "behindality":
            self.switchToMainTabBar()
            
        case "limincollectionial":
            if let body = body {
                self.toEmail(body: body)
            }
            
        case "tersTVo":
            self.rankStore()
            
        default:
            break
        }
    }
}

extension H5ViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        progressView.isHidden = false
        progressView.alpha = 1
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        progressView.isHidden = true
    }
}

extension H5ViewController: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        handleH5Call(methodName: message.name, body: message.body)
    }
}

extension H5ViewController {
    
    private func switchToMainTabBar() {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        let tabBarController = BaseTabBarController()
        
        UIView.transition(with: window, duration: 0.25, options: .transitionCrossDissolve) {
            window.rootViewController = tabBarController
        }
    }
    
    func rankStore() {
        guard #available(iOS 14.0, *),
              let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return
        }
        SKStoreReviewController.requestReview(in: windowScene)
    }
    
    private func toEmail(body: Any) {
        guard let email = body as? String, !email.isEmpty else {
            return
        }
        
        let phone = SecureUserManager.getPhone() ?? ""
        let body = "Cair Yuk: \(phone)"
        
        guard let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed),
              let emailURL = URL(string: "mailto:\(email)?body=\(encodedBody)"),
              UIApplication.shared.canOpenURL(emailURL) else {
            return
        }
        
        UIApplication.shared.open(emailURL)
    }
    
    func createRequestUrl(baseUrl: String) -> URL? {
        let deviceParameters = DeviceInfoCollector().collectAllParameters()
        
        guard var components = URLComponents(string: baseUrl) else { return nil }
        
        var allQueryItems = components.queryItems ?? []
        
        let deviceQueryItems = deviceParameters.map { URLQueryItem(name: $0.key, value: $0.value) }
        allQueryItems.append(contentsOf: deviceQueryItems)
        
        components.queryItems = allQueryItems
        
        return components.url
    }
}
