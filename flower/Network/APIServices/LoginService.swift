//
//  LoginService.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 3..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Alamofire

/** 로그인 */
struct LoginService: APIManager, Requestable {
    
    typealias NetworkData = ResponseObject<Token>
    static let shared = LoginService()
    let loginURL = url("/login")
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    func login(id: String, password:String, completion: @escaping(NetworkData) -> Void){
        let body = [
            "userId" : id,
            "userPw" : password
        ]
        
        postable(loginURL, body: body, header: headers) { res in
            switch res {
            case .success(let value):
                completion(value)
                print("login success")
            case .error(let value):
                completion(value)
                print("login failed")
            }
        }
    }
}
