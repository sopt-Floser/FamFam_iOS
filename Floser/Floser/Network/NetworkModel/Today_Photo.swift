//
//  Today_Photo.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 6..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import ObjectMapper

// 오늘의 하루 - 게시글 - 사진 양식
struct Today_Photo: Mappable {
    var photoIdx : Int?
    var photoName : String?
    var createdAt: Date?
    var contentIdx: Int?
    var userIdx : Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        photoIdx  <- map["photoIdx"]
        photoName <- map["photoName"]
        createdAt <- map["createdAt"]
        contentIdx <- map["contentIdx"]
        userIdx <- map["userIdx"]
    }
}
