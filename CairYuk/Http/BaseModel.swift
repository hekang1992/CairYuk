//
//  BaseModel.swift
//  CairYuk
//
//  Created by hekang on 2026/3/8.
//

class BaseModel: Codable {
    var securityair: String?
    var northature: String?
    var fatherarium: fatherariumModel?
    
    private enum CodingKeys: String, CodingKey {
        case securityair, northature, fatherarium
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        if let intValue = try? container.decode(Int.self, forKey: .securityair) {
            securityair = String(intValue)
        } else {
            securityair = try? container.decode(String.self, forKey: .securityair)
        }
        
        northature = try? container.decode(String.self, forKey: .northature)
        fatherarium = try? container.decode(fatherariumModel.self, forKey: .fatherarium)
    }
    
    
}

class fatherariumModel: Codable {
    var prehensship: String?
    var attorneyeur: attorneyeurModel?
    var almostice: String?
    var patriise: String?
    var publicfic: [publicficModel]?
}

class attorneyeurModel: Codable {
    var cribrdoctoration: String?
    var pilair: String?
    var everyment: String?
    var necrify: String?
}

class publicficModel: Codable {
    var participantarian: String?
    var popularship: String?
    var technivity: String?
}
