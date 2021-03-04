//
//  ResponseObject.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 3..
//  Copyright © 2019년 성다연. All rights reserved.
//

import ObjectMapper

struct ResponseObject<T: Mappable>:Mappable {
    var status: Int?
    var message: String?
    var data: T?
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        status <- map["status"]
        message <- map["message"]
        data <- map["data"]
    }
}
