//
//  SignService.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 3..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Alamofire

/** 회원가입 */
struct SignService : APIManager, Requestable {
    typealias NetworkData = ResponseObject<Sign_Model>
    static let shared = SignService()
    let userURL = url("/users")
    let userDefaults = UserDefaults.standard
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    func signUp(name:String, id:String, password:String, phone:String, birthday: String, sextype:Int, completion: @escaping (NetworkData) -> Void) {
        
        let body = [
            "userName" : name,
            "userId" : id,
            "userPw" : password,
            "userPhone" : phone,
            "birthday" : birthday,
            "sexType" : sextype
            
            ] as [String : Any]
        
        postable(userURL, body: body, header: headers){ res in
            switch res {
            case .success(let value):
                completion(value)
                print("sign up success")
            case .error(let value):
                completion(value)
                print("sign up failed")
            }
        }
    }

}
