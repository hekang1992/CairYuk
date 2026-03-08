//
//  AppViewModel.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

import Foundation
import Combine

class AppViewModel: ObservableObject {
    
    @Published var model: BaseModel?
    
    func launchInfo(parameters: [String: Any]) {
        
        Task {
            
            do {
                
                model = try await AppService.launchInfo(parameters: parameters)
                
            } catch {
                
                print("error===\(error)")
                
            }
            
        }
        
    }
    
}
