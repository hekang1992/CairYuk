//
//  ToastManager.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

import UIKit
import Toast_Swift

class ToastManager {
    
    private static func showOnWindow(_ text: String) {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let window = windowScene.windows.first else { return }
        
        DispatchQueue.main.async {
            window.makeToast(text, duration: 3.0, position: .center)
        }
    }
}

extension UIColor {
    convenience init(hexString: String) {
        var hex = hexString.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if hex.hasPrefix("#") {
            hex.remove(at: hex.startIndex)
        }
        
        var rgbValue: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&rgbValue)
        
        let r, g, b, a: CGFloat
        
        switch hex.count {
        case 6:
            r = CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgbValue & 0x0000FF) / 255.0
            
            a = 1.0
            
        default:
            r = 0; g = 0; b = 0; a = 1.0
        }
        
        self.init(red: r, green: g, blue: b, alpha: a)
    }
}

extension CGFloat {
    func pix() -> CGFloat {
        return self / 375.0 * UIScreen.main.bounds.width
    }
}

extension Double {
    func pix() -> CGFloat {
        return CGFloat(self) / 375.0 * UIScreen.main.bounds.width
    }
}

extension Int {
    func pix() -> CGFloat {
        return CGFloat(self) / 375.0 * UIScreen.main.bounds.width
    }
}
