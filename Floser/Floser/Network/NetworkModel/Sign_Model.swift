//
//  Sign_Model.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 6..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import ObjectMapper


/*
 "userId": "tnwjddl",
 "userName": "sujung",
 "userPhone": "01012345678",
 "birthday": "1995-01-01T00:00",
 "sexType": 0,
 "statusMessage": "상태메세지를 등록하세요.",
 "profilePhoto": null,
 "backPhoto": null,
 "groupIdx": -1
 */
struct Sign_Model : Mappable {
    var userId: String?
    var userName: String?
    var userPhone: String?
    var birthday: String?
    var sexType: Int?
    var statusMessage: String?
    var profilePhoto: String?
    var backPhoto: String?
    var groupIdx: Int?
    
    init?(map: Map) {
        
    }
    
    mutating func mapping(map: Map) {
        userId <- map["userId"]
        userName <- map["userName"]
        userPhone <- map["userPhone"]
        birthday <- map["birthday"]
        sexType <- map["sexType"]
        statusMessage <- map["statusMessage"]
        profilePhoto <- map["profilePhoto"]
        backPhoto <- map["backPhoto"]
        groupIdx <- map["groupIdx"]
    }
}
