//
//  AppService.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

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
