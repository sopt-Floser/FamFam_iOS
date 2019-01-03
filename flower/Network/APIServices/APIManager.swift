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
        return "baseURL" + path
    }
}
