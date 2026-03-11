//
//  AppService.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

import UIKit

class AppService {
    
    static func launchInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/publicfic",
            parameters: parameters
        )
        
        return result
    }
    
}

extension AppService {
    
    static func codeInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/ratherine",
            parameters: parameters
        )
        
        return result
    }
    
    static func loginInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/securityair",
            parameters: parameters
        )
        
        return result
    }
    
}

extension AppService {
    
    static func centerInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.get(
            url: "/old/fightitude",
            parameters: parameters
        )
        
        return result
    }
    
}

extension AppService {
    
    static func outInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.get(
            url: "/old/northature",
            parameters: parameters
        )
        
        return result
    }
    
    static func deleteInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.get(
            url: "/old/hippoability",
            parameters: parameters
        )
        
        return result
    }
    
    
}

extension AppService {
    
    static func getHomeInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.get(
            url: "/old/fatherarium",
            parameters: parameters
        )
        
        return result
    }
    
}

extension AppService {
    
    static func clickProductInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/hetero",
            parameters: parameters
        )
        
        return result
    }
    
}

extension AppService {
    
    static func productDetailInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/cytality",
            parameters: parameters
        )
        
        return result
    }
    
}

extension AppService {
    
    static func orderListInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/botanitor",
            parameters: parameters
        )
        
        return result
    }
    
}

extension AppService {
    
    static func authCardInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.get(
            url: "/old/electosity",
            parameters: parameters
        )
        
        return result
    }
    
}

extension AppService {
    
    static func uploadFrontCardInfo(parameters: [String: Any], images: [UIImage]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.postWithImage(
            url: "/old/eye",
            parameters: parameters,
            images: images
        )
        
        return result
    }
    
}

extension AppService {
    
    static func saveCardInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        if LanguageManager.shared.currentType == .indonesian {
            let result: BaseModel = try await NetworkManager.shared.post(
                url: "/old/conferencean",
                parameters: parameters
            )
            
            return result
            
        }else {
            let result: BaseModel = try await NetworkManager.shared.post(
                url: "/old/modernsome",
                parameters: parameters
            )
            
            return result
        }
        
        
    }
    
}

extension AppService {
    
    static func getPersonalInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/balosure",
            parameters: parameters
        )
        
        return result
    }
    
    static func savePersonalInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/phant",
            parameters: parameters
        )
        
        return result
    }
    
}

extension AppService {
    
    static func getWorkInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/nugous",
            parameters: parameters
        )
        
        return result
    }
    
    static func saveWorkInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/hepatery",
            parameters: parameters
        )
        
        return result
    }
    
}

extension AppService {
    
    static func getBankInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/cordacity",
            parameters: parameters
        )
        
        return result
    }
    
    static func saveBankInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/donfold",
            parameters: parameters
        )
        
        return result
    }
    
}

extension AppService {
    
    static func getContactInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/popularship",
            parameters: parameters
        )
        
        return result
    }
    
    static func saveContactInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/technivity",
            parameters: parameters
        )
        
        return result
    }
    
    static func uploadContactsInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/opisthperiodcy",
            parameters: parameters
        )
        
        return result
    }
    
}

extension AppService {
    
    static func applyOrderInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        LoadingView.shared.show()
        
        defer {
            LoadingView.shared.hide()
        }
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/foldfishess",
            parameters: parameters
        )
        
        return result
    }
    
}

extension AppService {
    
    static func uploadLocationInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/recentlyian",
            parameters: parameters
        )
        
        return result
    }
    
    static func uploadAppMessageInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/withoutess",
            parameters: parameters
        )
        
        return result
    }
    
    static func appFllowInfo(parameters: [String: Any]) async throws -> BaseModel? {
        
        let result: BaseModel = try await NetworkManager.shared.post(
            url: "/old/abovesive",
            parameters: parameters
        )
        
        return result
    }
    
}
