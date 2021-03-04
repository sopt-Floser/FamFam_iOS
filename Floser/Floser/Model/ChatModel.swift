//
//  ChatModel.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 7..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation

// 말풍선 하나
struct ChatMessage {
    var fromUserId:String
    var text:String
    var timestamp: NSNumber
}

struct Group {
    var key: String
    var name:String
    var message:Dictionary<String, Int>
    
    init(key:String, name:String){
        self.key = key
        self.name = name
        self.message = [:]
    }
    
    init(key:String, data:Dictionary<String, AnyObject>){
        self.key = key
        self.name = data["name"] as! String
        if let message = data["message"] as? Dictionary<String,Int> {
            self.message = message
        } else {
            self.message = [:]
        }
    }
}

// 사용자
struct User {
    var uid:String
    var phone:String
    var username: String
    var group:Dictionary<String, String>
    
    init(uid:String, phone:String, username:String) {
        self.uid = uid
        self.phone = phone
        self.username = username
        self.group = [:]
    }
}
