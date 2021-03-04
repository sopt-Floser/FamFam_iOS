//
//  Calendar_Month.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 6..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import ObjectMapper

// 공유캘린더 - 월별 일정 조회
struct Calendar_Month : Mappable{
    var individuals : [Calendar_individual]?
    var familys : [Calendar_family]?
    var anniversarys : [Calendar_anniversary]?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        individuals <- map["individual"]
        familys <- map["family"]
        anniversarys <- map["anniversary"]
    }
    
}
