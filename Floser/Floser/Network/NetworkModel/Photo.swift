//
//  Photo.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 7..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import ObjectMapper

struct Photo : Mappable {
    var totalPage: Int?
    var photos: [Today_Photo]?
    
    init?(map: Map) {
        
    }
    mutating func mapping(map: Map) {
        totalPage <- map["totalPage"]
        photos <- map["photos"]
    }
}
