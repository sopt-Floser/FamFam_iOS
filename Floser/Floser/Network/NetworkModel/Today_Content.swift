//
//  Today_Content.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 6..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import ObjectMapper

// 오늘의 하루 - 게시글 - 내용 양식
struct Today_Content : Mappable {
    var contentIdx : Int?
    var content : String?
    var createdAt : String?
    var commentCount: Int?
    var userIdx : Int?
    var groupIdx : Int?
    
    init?(map: Map) {
        
    }

    
    mutating func mapping(map: Map) {
        contentIdx  <- map["contentIdx"]
        content <- map["content"]
        createdAt <- map["createdAt"]
        commentCount <- map["commentCount"]
        userIdx <- map["userIdx"]
        groupIdx <- map["groupIdx"]
    }

}
