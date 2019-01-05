//
//  Today_Feel.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 6..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import ObjectMapper

// 오늘의 하루, 홈 - 감정표현
struct Today_Feel : Mappable{
    var types : [Today_Feel_Types]?
    var firstUserName : String?
    var feelCount : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        types <- map["types"]
        firstUserName <- map["firstUserName"]
        feelCount <- map["feelCount"]
    }
}
