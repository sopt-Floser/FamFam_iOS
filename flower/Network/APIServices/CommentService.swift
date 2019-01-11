//
//  CommentService.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 7..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import Alamofire

struct CommentService : APIManager, Requestable {
    typealias NetworkData = ResponseArray<TodayComment>
    
    static let shared = CommentService()
    let commentURL = url("/comments")
    let uploadheader : HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "token") ?? "no Token"
    ]
    let uploadHeaders: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "token") ?? "no Token",
        "Content-Type": "application/json"
    ]
    
    // 댓글 조회
    func getComment(contentIdx:Int, completion:@escaping (NetworkData)-> Void){
        let queryURL = commentURL + "/contents/\(contentIdx)"
        get(queryURL, body: nil, header: uploadheader){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
            
        }
        
    }
    
    
    
    // 댓글 등록
    func writeComment(contentIdx:Int, content:String?, completion:@escaping(NetworkData) -> Void){
        
        let queryURL = commentURL + "/contents/\(contentIdx)"
        
        let body = [
            "content" : content
        ]
        
        post(queryURL, body: body, header: uploadHeaders){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
    }
    
    // 댓글 삭제
    func deleteComment(commentIdx:String?,completion:@escaping(NetworkData)->Void){
        let queryUrl = commentURL + "/\(commentIdx)"
        
        delete(queryUrl, body: nil, header: uploadheader){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
            
        }
    }
}
