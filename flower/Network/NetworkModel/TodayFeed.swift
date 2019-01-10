//
//  TodayFeed.swift
//  flower
//
//  Created by 김지민 on 10/01/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import Foundation
import ObjectMapper

// 오늘의 하루 - 게시글 양식
struct TodayFeed : Mappable {
    var contents : [Today_Contents]?
    var totalPage : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        contents <- map["contents"]
        totalPage <- map["totalPage"]
    }
    
}
