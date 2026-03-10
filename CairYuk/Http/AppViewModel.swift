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
    
    @Published var codeModel: BaseModel?
    
    @Published var loginModel: BaseModel?
    
    @Published var centerModel: BaseModel?
    @Published var centerMsg: String?
    
    @Published var outModel: BaseModel?
    
    @Published var deleteModel: BaseModel?
    
    @Published var homeModel: BaseModel?
    @Published var homeMsg: String?
    
    
    @Published var clickProductModel: BaseModel?
    @Published var clickProductMsg: String?
    
    @Published var productDetailModel: BaseModel?
    @Published var productDetailMsg: String?
    
    @Published var orderListModel: BaseModel?
    @Published var orderListMsg: String?
    
    
    
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

extension AppViewModel {
    
    func codeInfo(parameters: [String: Any]) {
        
        Task {
            
            do {
                
                codeModel = try await AppService.codeInfo(parameters: parameters)
                
            } catch {
                
                print("error===\(error)")
                
            }
            
        }
        
    }
    
    func loginInfo(parameters: [String: Any]) {
        
        Task {
            
            do {
                
                loginModel = try await AppService.loginInfo(parameters: parameters)
                
            } catch {
                
                print("error===\(error)")
                
            }
            
        }
        
    }
    
}

extension AppViewModel {
    
    func centerInfo(parameters: [String: Any]) {
        
        Task {
            
            do {
                
                centerModel = try await AppService.centerInfo(parameters: parameters)
                
            } catch {
                
                centerMsg = error.localizedDescription
                
            }
            
        }
        
    }
}

extension AppViewModel {
    
    func outInfo(parameters: [String: Any]) {
        
        Task {
            
            do {
                
                outModel = try await AppService.outInfo(parameters: parameters)
                
            } catch {
                
                print("error===\(error)")
                
            }
            
        }
        
    }
    
    func deleteInfo(parameters: [String: Any]) {
        
        Task {
            
            do {
                
                deleteModel = try await AppService.deleteInfo(parameters: parameters)
                
            } catch {
                
                print("error===\(error)")
                
            }
            
        }
        
    }
    
}

extension AppViewModel {
    
    func homeInfo(parameters: [String: Any]) {
        
        Task {
            
            do {
                
                homeModel = try await AppService.getHomeInfo(parameters: parameters)
                
            } catch {
                
                homeMsg = error.localizedDescription
                
            }
            
        }
        
    }
    
}

extension AppViewModel {
    
    func clickProcutInfo(parameters: [String: Any]) {
        
        Task {
            
            do {
                
                clickProductModel = try await AppService.clickProductInfo(parameters: parameters)
                
            } catch {
                
                clickProductMsg = error.localizedDescription
                
            }
            
        }
        
    }
    
}

extension AppViewModel {
    
    func procutDetailInfo(parameters: [String: Any]) {
        
        Task {
            
            do {
                
                productDetailModel = try await AppService.productDetailInfo(parameters: parameters)
                
            } catch {
                
                productDetailMsg = error.localizedDescription
                
            }
            
        }
        
    }
    
}

extension AppViewModel {
    
    func orderListlInfo(parameters: [String: Any]) {
        
        Task {
            
            do {
                
                orderListModel = try await AppService.orderListInfo(parameters: parameters)
                
            } catch {
                
                orderListMsg = error.localizedDescription
                
            }
            
        }
        
    }
    
}
