//
//  TodayService.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 3..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import Alamofire

/** 오늘의 하루 */
struct TodayService: APIManager, Requestable {
    
    typealias NetworkData = ResponseObject<Today_Contents> //ResponseArray
    static let shared = TodayService()
    let todayURL = url("/contents")
    let header: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    let uploadHeader: HTTPHeaders = [
        "Authorization" : UserDefaults.standard.string(forKey: "token") ?? "no token"
    ]
    let uploadBothHeader:HTTPHeaders = [
        "Content-Type": "application/json",
        "Authorization" : UserDefaults.standard.string(forKey: "token") ?? "no token"
    ]
    let uploadDataHeader: HTTPHeaders = [
        "Authorization" : UserDefaults.standard.string(forKey: "token") ?? "no token",
        "Content-Type" : "multipart/form-data"
    ]
    
    // 이번주 컨텐츠 수 조회 (홈)
//    func getContentCount(completion:@escaping(Int) -> Void){
//        let queryURL = todayURL + "/count/week"
//
//        gettable(queryURL, body: nil, header: uploadHeader){ res in
//            switch res {
//            case .success(let value):
//                guard let weekContentCount = value.dat
//                completion(weekContentCount)
//            case .error(let error):
//                print(error)
//            }
//
//        }
//    }
    
    
    // 모든 컨텐츠 조회
    func getAllContent(page_no : Int? = 0, page_size : Int? = 5, completion: @escaping ([Today_Contents])-> Void){
        let queryURL = todayURL + "?page=\(page_no ?? 0)&size=\(page_size ?? 0)"
        
        get(queryURL, body: nil, header: uploadHeader){ res in
            switch res {
            case .success(let value):
                guard let contentsList = value.data else {return}
                completion([contentsList])
            case .error(let error):
                print(error)
            }
        }
    }
    
    // 해당 컨텐츠 조회
    func getOneContent(contentIdx:Int? = 0, completion: @escaping(Today_Contents) -> Void){
        let queryURL = todayURL + "/\(contentIdx)"
        
        get(queryURL, body: nil, header: uploadHeader){ res in
            switch res {
            case .success(let value):
                guard let contents = value.data else {return}
                completion(contents)
            case .error(let error):
                print(error)
            }
            
        }
    }
    
    // 게시글 작성
    func writeContent(content:String? = "", photos:[Today_Photo]?, completion: @escaping(NetworkData) -> Void){
        let queryURL = todayURL
        
        let body = [
            "content" : content,
            "photos" : [Today_Photo]()
        ] as [String:Any]
        
        post(queryURL, body: body, header: uploadDataHeader){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
            
        }
    }
    
    // 해당 컨텐츠 수정
    func editContent(contentIdx:String? = "", content:String?, completion: @escaping(NetworkData) -> Void){
        let queryURL = todayURL + "/\(contentIdx)"
        
        let body = [
            "content" : content
        ]
        
        post(queryURL, body: body, header: uploadBothHeader){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
    }
    
    // 해당 컨텐츠 삭제
    func deleteContent(contentIdx : Int? = 0, completion:@escaping(NetworkData) -> Void){
        let queryURL = todayURL + "/\(contentIdx)"
        
        post(queryURL, body: nil, header: uploadHeader){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
    }
}
