//
//  AppDeviceConfig.swift
//  CairYuk
//
//  Created by hekang on 2026/3/11.
//

import UIKit
import Network
import AdSupport
import CoreTelephony
import MachO
import SystemConfiguration
import DeviceKit
import NetworkExtension

extension UIDevice {
    
    func rubraticInfo() -> [String: Any] {
        
        var dict: [String: Any] = [:]
        
        if let attr = try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory()) {
            
            if let total = attr[.systemSize] as? NSNumber {
                dict["pubgroundior"] = total.int64Value
            }
            
            if let free = attr[.systemFreeSize] as? NSNumber {
                dict["clementee"] = free.int64Value
            }
        }
        
        dict["aory"] = ProcessInfo.processInfo.physicalMemory
        
        if let freeMem = availableMemory() {
            dict["powerition"] = freeMem
        }
        
        return dict
    }
    
    func pudeInfo() -> [String: Any] {
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        
        var dict: [String: Any] = [:]
        
        dict["several"] = Int(UIDevice.current.batteryLevel * 100)
        
        dict["omasth"] = UIDevice.current.batteryState == .charging ? 1 : 0
        
        return dict
    }
    
    func angiteInfo() -> [String: Any] {
        
        let screen = UIScreen.main.bounds
        
        var dict: [String: Any] = [:]
        
        dict["raphion"] = UIDevice.current.systemVersion
        dict["librfinancialorium"] = "iPhone"
        dict["explainless"] = deviceCode()
        dict["importantess"] = deviceName()
        dict["maniapracticeaster"] = Int(screen.height)
        dict["stillet"] = Int(screen.width)
        dict["loseaneity"] = screenSize()
        
        return dict
    }
    
    func scelcertainivityInfo() -> [String: Any] {
        var dict: [String: Any] = [:]
        dict["partyless"] = "0"
        dict["felicitency"] = isSimulator() ? 1 : 0
        dict["rhag"] = isJailbroken() ? 1 : 0
        dict["meritmake"] = String(Int(12 + 88))
        
        return dict
    }
    
    func himselfarianInfo(bssid: String?) -> [String: Any] {
        
        var dict: [String: Any] = [:]
        
        dict["volaence"] = TimeZone.current.abbreviation() ?? ""
        dict["should"] = isAppProxy() ? 1 : 0
        dict["emulincreaseable"] = isVPN() ? 1 : 0
        dict["clavade"] = carrierName()
        dict["degreeie"] = IDFVKeychainManager.shared.getIDFV()
        dict["bissouthaire"] = Locale.current.identifier
        dict["candidateless"] = currentNetworkType()
        dict["liev"] = Device.current.isPhone ? "1" : "0"
        dict["guess"] = ipAddress()
        dict["pancreatico"] = bssid ?? ""
        dict["thalaman"] = IDFVKeychainManager.shared.getIDFA()
        
        return dict
    }
}

extension UIDevice {
    
    func fetchWiFiInfo(completion: @escaping ([String: Any], String?) -> Void) {
        
        DispatchQueue.global().async {
            
            var result: [String: Any] = [:]
            var wifiArray: [[String: Any]] = []
            var currentBSSID: String?
            
            let semaphore = DispatchSemaphore(value: 0)
            
            NEHotspotNetwork.fetchCurrent { hotspotNetwork in
                defer { semaphore.signal() }
                
                guard let network = hotspotNetwork else { return }
                
                let ssid = network.ssid
                let bssid = network.bssid
                
                var wifi: [String: Any] = [:]
                
                wifi["shakeier"] = ssid
                wifi["traveleous"] = ssid
                wifi["versistic"] = bssid
                wifi["pancreatico"] = bssid
                currentBSSID = bssid
                
                wifiArray.append(wifi)
            }
            
            semaphore.wait()
            
            result["rememberency"] = wifiArray
            
            DispatchQueue.main.async {
                completion(result, currentBSSID)
            }
        }
    }
}

extension UIDevice {
    
    func availableMemory() -> Int64? {
        
        var stats = vm_statistics64()
        
        var count = mach_msg_type_number_t(
            MemoryLayout<vm_statistics64>.size / MemoryLayout<integer_t>.size
        )
        
        let hostPort = mach_host_self()
        
        let result = withUnsafeMutablePointer(to: &stats) {
            
            $0.withMemoryRebound(to: integer_t.self, capacity: Int(count)) {
                
                host_statistics64(hostPort, HOST_VM_INFO64, $0, &count)
            }
        }
        
        if result == KERN_SUCCESS {
            
            return Int64(stats.free_count) * Int64(vm_page_size)
        }
        
        return nil
    }
}

extension UIDevice {
    
    func buildDeviceInfo(completion: @escaping ([String: Any]) -> Void) {
        
        var result: [String: Any] = [:]
        
        result["rubratic"] = rubraticInfo()
        result["pude"] = pudeInfo()
        result["angite"] = angiteInfo()
        result["scelcertainivity"] = scelcertainivityInfo()
        
        fetchWiFiInfo { wifi, bssid  in
            
            result["sixization"] = wifi
            result["himselfarian"] = self.himselfarianInfo(bssid: bssid)
            
            completion(result)
        }
    }
}

extension UIDevice {
    
    func deviceCode() -> String {
        return Device.identifier
    }
    
    func deviceName() -> String {
        return Device.current.description
    }
    
    func screenSize() -> String {
        return String(Device.current.diagonal)
    }
    
    func isSimulator() -> Bool {
        return Device.current.isSimulator
    }
    
    func isJailbroken() -> Bool {
        
#if targetEnvironment(simulator)
        return false
#else
        
        let paths = [
            "/Applications/Cydia.app",
            "/bin/bash",
            "/usr/sbin/sshd",
            "/etc/apt"
        ]
        
        for path in paths {
            if FileManager.default.fileExists(atPath: path) {
                return true
            }
        }
        
        return false
#endif
    }
    
    func carrierName() -> String {
        
        let network = CTTelephonyNetworkInfo()
        
        if let carrier = network.serviceSubscriberCellularProviders?.values.first {
            return carrier.carrierName ?? ""
        }
        
        return ""
    }
    
    func currentNetworkType() -> String {
        return UserDefaults.standard.string(forKey: "netwotk_status") ?? ""
    }
    
    func ipAddress() -> String {
        
        var address = ""
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        
        if getifaddrs(&ifaddr) == 0 {
            
            var ptr = ifaddr
            
            while ptr != nil {
                
                defer { ptr = ptr?.pointee.ifa_next }
                
                let interface = ptr?.pointee
                
                let addrFamily = interface?.ifa_addr.pointee.sa_family
                
                if addrFamily == UInt8(AF_INET) {
                    
                    if let name = interface?.ifa_name,
                       String(cString: name) == "en0" {
                        
                        var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                        
                        getnameinfo(
                            interface?.ifa_addr,
                            socklen_t((interface?.ifa_addr.pointee.sa_len)!),
                            &hostname,
                            socklen_t(hostname.count),
                            nil,
                            socklen_t(0),
                            NI_NUMERICHOST
                        )
                        
                        address = String(cString: hostname)
                    }
                }
            }
            
            freeifaddrs(ifaddr)
        }
        
        return address
    }
    
    func isVPN() -> Bool {
        
        if let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
           let scoped = settings["__SCOPED__"] as? [String: Any] {
            
            for key in scoped.keys {
                if key.contains("tap") || key.contains("tun") || key.contains("ppp") {
                    return true
                }
            }
        }
        
        return false
    }
    
    func isAppProxy() -> Bool {
        
        guard let settings = CFNetworkCopySystemProxySettings()?.takeRetainedValue() as? [String: Any],
              let httpEnable = settings[kCFNetworkProxiesHTTPEnable as String] as? Int else {
            return false
        }
        
        return httpEnable == 1
    }
}
