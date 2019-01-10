//
//  PhotoService.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 7..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import Alamofire

struct PhotoService : APIManager, Requestable {
    typealias NetworkData = ResponseObject<Photo>
    static let shared = PhotoService()
    let photoURL = url("/photos")
    let header: HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "token") ?? "no Token"
    ]
    
    func getEntirePhotos(page_no:Int?, page_size:Int?, completion:@escaping(NetworkData) -> Void){
        let queryURL = photoURL + "?userIdx=&page=\(page_no ?? 0)&size=\(page_size ?? 20)"
        get(queryURL, body: nil, header: header){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
    }
    
    func getPersonalPhotos(userIdx:Int?, page_no:Int?, page_size:Int?, completion:@escaping(NetworkData) -> Void){
        let queryURL = photoURL + "?userIdx=\(userIdx)&page=\(page_no ?? 0)&size=\(page_size ?? 20)"
        get(queryURL, body: nil, header: header){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
    }

}
