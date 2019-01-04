//
//  APIManager.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 3..
//  Copyright © 2019년 성다연. All rights reserved.
//

protocol APIManager {}

extension APIManager {
    static func url(_ path: String) -> String {
        return "http://ec2-52-79-139-30.ap-northeast-2.compute.amazonaws.com:8080" + path
    }
}
