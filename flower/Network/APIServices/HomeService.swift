//
//  HomeService.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 7..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import Alamofire

struct HomeService : APIManager, Requestable {
    typealias NetworkData = ResponseObject<CountModel>
    static let shared = HomeService()
    let homeURL = url("")
    let header : HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "token") ?? "no Token"
    ]
    
    // 이번주 댓글 수 조회
    func getCommentcount(completion: @escaping(NetworkData)->Void){
        let query = homeURL + "/comments/count/week"
        
        get(query, body: nil, header: header){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
    }
    
    // 이번주 감정 수 조회
    func getFeelCount(completion: @escaping(NetworkData)-> Void){
        let query = homeURL + "/feels/count/week"
        
        get(query, body: nil, header: header){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
    }
    
    // 이번주 게시물 수 조회
    func getContentCount(completion:@escaping(NetworkData) -> Void){
        let query = homeURL + "/contents/count/week"
        
        get(query, body: nil, header: header){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
    }
    
    // 미션 가져오기 (api 아직 안나옴)
    func getMission(completion:@escaping(NetworkData) -> Void){
        let query = homeURL
        
    }
    
    // 알림 가져오기 (api 아직 안나옴)
    func getAlarm(completion:@escaping(NetworkData) -> Void){
        let query = homeURL
    }
    
}
