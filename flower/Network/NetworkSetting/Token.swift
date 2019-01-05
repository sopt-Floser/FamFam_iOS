//
//  Token.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 3..
//  Copyright © 2019년 성다연. All rights reserved.
//

import ObjectMapper

struct Token: Mappable {
    
    var token: String?
    
    init?(map: Map) {}
    
    mutating func mapping(map: Map) {
        token <- map["token"]
    }
}
