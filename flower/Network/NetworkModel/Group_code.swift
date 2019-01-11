//
//  Group_code.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 7..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import ObjectMapper

struct Group_code : Mappable {
    var code: String?
    var expiredAt: String?
    init?(map: Map) {
        
    }
    
    
    
    mutating func mapping(map: Map) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSSZ"
        
        code <- map["code"]
        expiredAt <- map["expiredAt"]
        
//        if let dateString = map["expiredAt"].currentValue as? String,
//            let _date = dateFormatter.date(from: dateString) {
//            expiredAt = _date
//        }
    }
}
