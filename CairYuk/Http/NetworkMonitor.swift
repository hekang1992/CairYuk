//
//  NetworkMonitor.swift
//  CairYuk
//
//  Created by hekang on 2026/3/9.
//

import Alamofire

class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    private let reachability = NetworkReachabilityManager()
    
    func startListen(callBack: @escaping (Bool, String) -> Void) {
        reachability?.startListening { status in
            switch status {
            case .notReachable:
                callBack(false, "notReachable")
                
            case .reachable(.cellular):
                callBack(true, "5G")
                
            case .reachable(.ethernetOrWiFi):
                callBack(true, "WIFI")
                
            case .unknown:
                callBack(false, "unknown")
            }
        }
    }
    
    func stopListen() {
        reachability?.stopListening()
    }
}
