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
    var cordacity: [cordacityModel]?
    var botanitor: String?
    var baloarian: baloarianModel?
    var listensive: [listensiveModel]?
    var myxen: listensiveModel?
    var actionproof: actionproofModel?
    var impactling: actionproofModel?
    var wayine: Int?
    var traveleous: String?
    var lucmomentair: String?
    var spherdom: String?
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

class cordacityModel: Codable {
    var donfold: String?
    var foldfishess: [foldfishessModel]?
}

class foldfishessModel: Codable {
    var maciactuallyally: Int?
    var acriestablish: String?
    var withoutess: String?
    var representic: String?
    var opisthperiodcy: String?
    var coupleacle: String?
    var onomat: String?
    var mammtreater: String?
    var salubrsure: String?
}

class baloarianModel: Codable {
    var ventise: String?
    var phasyform: String?
    var maciactuallyally: String?
    var acriestablish: String?
    var plec: String?
    var withoutess: String?
    var stirpoon: String?
}

class listensiveModel: Codable {
    var participantarian: String?
    var spargenne: String?
    var seeketic: String?
    var arhitty: Int?
    var emeuous: String?
    var pteratory: String?
}

class actionproofModel: Codable {
    var botanitor: String?
    var familianeity: familianeityModel?
}

class familianeityModel: Codable {
    var traveleous: String?
    var lucmomentair: String?
    var spherdom: String?
}
