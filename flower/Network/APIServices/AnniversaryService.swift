//
//  AnniversaryService.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 7..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import Alamofire

struct Anniversary : APIManager, Requestable {
    typealias NetworkData = ResponseArray<Calendar_anniversary>
    static let shared = Anniversary()
    let anniversaryURL = url("/anniversary")
    let header : HTTPHeaders = [
        "Content-Type": "application/json",
        "Authorization": UserDefaults.standard.string(forKey: "token") ?? "no Token"
    ]
    
    // 기념일 전체 목록 조회
    func getAllAnniversaryList(completion: @escaping ([Calendar_anniversary]) -> Void){
        let queryURL = anniversaryURL
        
        get(queryURL, body: nil, header: header){ res in
            switch res {
            case .success(let value):
                guard let anniversaryList = value.data else {return}
                completion(anniversaryList)
            case .error(let error):
                print(error)
            }
        }
    }
    
    // 기념일 추가
    func addAnniversary(anniversaryType:Int? = 3, content:String?, dateStr: String?, completion:@escaping(NetworkData) -> Void){
        let queryURL = anniversaryURL + "/\(anniversaryType)"
        
        let body = [
            "content" : content,
            "dateStr" : dateStr
        ]
        
        post(queryURL, body: body, header: header){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
                
            }
        }
    }
    
    // 기념일 수정
    func editAnniversary(anniversaryIdx:Int? = 3, dateStr:String?, completion:@escaping(NetworkData)->Void){
        let queryURL = anniversaryURL + "/\(anniversaryIdx)"
        
        let body = [
            "dateStr" : dateStr
        ]
        
        put(queryURL, body: body, header: header){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
                
            }
            
        }
    }
    
    // 기념일 삭제
    func deleteAnniversary(anniversaryIdx:[Int], completion:@escaping(NetworkData) -> Void){
        
        let body = [
            "anniversaryIdx" : anniversaryIdx
        ]
        delete(anniversaryURL, body: body, header: header){ res in
            switch res{
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
    }
}
