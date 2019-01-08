//
//  UserService.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 8..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import Alamofire

struct UserService: APIManager, Requestable {
    typealias NetworkData = ResponseObject<Sign_Model>
    static let shared = UserService()
    let userURL = url("/users")
    let header :HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    let uploadHeader: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "token") ?? "no Token"
    ]
    
    // 회원 조회
    func getUserInfo(){
        
    }
    
    // 그룹 조회
    func getGroupInfo(){
        
    }
    
    // 회원 정보 수정
    func editUserInfo(){
        
    }
    
    // 비밀번호 조회
    func checkPassword(){
        
    }
    
    // 비밀번호 수정
    func editPassword(){
        
    }
    
    // 회원 탈퇴
    func quitUser(){
        
    }
}
