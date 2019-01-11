//
//  Today_Comments_Model.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 6..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import ObjectMapper
// 오늘의 하루 - 댓글 하나 양식
struct TodayComment : Mappable {
    var commentIdx: Int?
    var content: String?
    var createdAt: String?
    var contentIdx: Int?
    var userIdx: Int?
    var userName: String?
    var userProfile: String?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        commentIdx <- map["commentIdx"]
        content <- map["content"]
        createdAt <- map["createAt"]
        contentIdx <- map["contentIdx"]
        userIdx <- map["userIdx"]
        userName <- map["userName"]
        userProfile <- map["userProfile"]
    }
}
