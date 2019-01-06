//
//  SignIdService.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 5..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Alamofire

/** 아이디 중복 체크 */
struct SignIdService : APIManager, Requestable {
    typealias NetworkData = ResponseObject<Token>
    static let shared = SignIdService()
    let userURL = url("/users/id")
    let userDefaults = UserDefaults.standard
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    func signUp(id:String, completion: @escaping (NetworkData) -> Void) {
        let body = [
            "userId" : id,
            ]
        postable(userURL, body: body, header: headers){ res in
            switch res {
            case .success(let value):
                completion(value)
                print("sign ID check success")
            case .error(let value):
                completion(value)
                print("sign ID check failed")
            }
        }
    }
    
}
