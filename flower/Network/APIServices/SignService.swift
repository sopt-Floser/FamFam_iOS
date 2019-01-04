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
    typealias NetworkData = ResponseObject<Token>
    static let shared = SignService()
    let userURL = url("/users")
    let userDefaults = UserDefaults.standard
    let headers: HTTPHeaders = [
        "Content-Type" : "application/json"
    ]
    
    func signUp(name:String, id:String, password:String, phone:String, birthday: Date, sextype:Int, completion: @escaping (Int) -> Void) {
        
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
                guard let rValue = value.status else {return}
                completion(rValue)
                print("sign up success")
            case .error(let error):
                guard let rValue = error.status else {return}
                completion(rValue)
                print("sign up failed")
            }
        }
    }

}
