//
//  Today_Contents.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 6..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import ObjectMapper

// 오늘의 하루 - 게시글 양식
struct Today_Contents : Mappable {
    var photos : [Today_Photo]?
    var content : Today_Content?
   
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        photos <- map["photos"]
        content <- map["content"]
    }

}
