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
struct Today_Comment_Model : Mappable {
    var commentIdx: Int?
    var content: String?
    var createdDate: Date?
    var contentIdx: Int?
    var userIdx: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        commentIdx <- map["commentIdx"]
        content <- map["content"]
        createdDate <- map["createDate"]
        contentIdx <- map["contentIdx"]
        userIdx <- map["userIdx"]
    }
}
