//
//  GroupCreateService.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 6..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Alamofire

struct GroupService :APIManager, Requestable{
    typealias NetworkData = ResponseObject<Group_code>
    static let shared = GroupService()
    let groupURL = url("/groups")
    
    let headers: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "token") ?? "no Token"
    ]
    let uploadHeader: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "token") ?? "no Token",
        "Content-Type" : "application/json"
    ]
    let uploadDataHeader: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "token") ?? "no Token",
        "Content-Type" : "multipart/form-data"
    ]
    
    // 그룹 생성
    func createGroup(completion:@escaping(NetworkData)->Void){
        post(groupURL, body: nil, header: headers){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
            
        }
    }
    
    // 그룹 참여
    func joinGroup(code:String?, completion:@escaping(NetworkData)->Void){
        let queryURL = groupURL + "/join"
        let body = [
            "code" : code
        ]
        
        post(queryURL, body: body, header: uploadHeader){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
    }
    
    // 그룹 수정
    func editGroup(homePhoto:String?, completion:@escaping(NetworkData) -> Void){
        let body = [
            "homePhoto" : homePhoto
        ]
        
        put(groupURL, body: body, header: uploadDataHeader){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
            
        }
    }
    
    // 그룹 탈퇴
    func disjoinGroup(completion:@escaping(NetworkData)->Void){
        let queryURL = groupURL + "/withdraw"
        
        delete(queryURL, body: nil, header: headers){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
    }
    
    // 그룹 초대 코드 / 생성 조회
    func inviteGroup(completion: @escaping(NetworkData)->Void){
        let queryURL = groupURL + "/invitation"
        
        get(queryURL, body: nil, header: headers){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
    }
}
