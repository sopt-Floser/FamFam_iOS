//
//  CountModel.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 8..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import ObjectMapper

struct CountModel : Mappable  {
    var count: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        count <- map["count"]
    }
}
