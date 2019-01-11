//
//  MissionModel.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 11..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import ObjectMapper

struct Mission_Model : Mappable{
    var missionIdx:Int?
    var missionType: Int?
    var suffixType:Int?
    var content: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        missionIdx <- map["missionIdx"]
        content <- map["content"]
    }
}

struct MissionModel : Mappable {
    var mission :Mission_Model?
    var target : String?
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        mission <- map["mission"]
        target <- map["target"]
    }
}
