//
//  Calendar_anniversary.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 6..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import ObjectMapper

// 공유캘린더 - 기념일 양식
struct Calendar_anniversary : Mappable{
    var anniversaryIdx: Int?
    var content: String?
    var date : String?
    var anniversaryType: Int?
    var groupIdx: Int?
    
    init?(map: Map) {
    }
    mutating func mapping(map: Map) {
        anniversaryIdx <- map["anniversaryIdx"]
        content <- map["content"]
        date <- map["date"]
        anniversaryIdx <- map["anniversaryType"]
        groupIdx <- map["groupIdx"]
    }
}
