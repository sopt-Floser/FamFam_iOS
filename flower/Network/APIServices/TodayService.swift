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
    typealias NetworkData = ResponseArray<Today_Contents>    //typealias NetworkData = ResponseObject<Today_Contents> //ResponseArray
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
    func getAllContent(page_no : Int? = 0, page_size : Int? = 5, completion: @escaping (NetworkData)-> Void){
        let queryURL = todayURL + "?page=\(page_no ?? 0)&size=\(page_size ?? 0)"
        
        get(queryURL, body: nil, header: uploadHeader){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
    }
    
    // 해당 컨텐츠 조회
//    func getOneContent(contentIdx:Int? = 0, completion: @escaping(Today_Contents) -> Void){
//        let queryURL = todayURL + "/\(contentIdx)"
//
//        get(queryURL, body: nil, header: uploadHeader){ res in
//            switch res {
//            case .success(let value):
//                guard let contents = value.data else {return}
//                completion(contents)
//            case .error(let error):
//                print(error)
//            }
//
//        }
//    }
    
    // 게시글 작성
    func writeContent(content:String, photos: [Today_Photo], completion: @escaping(NetworkData) -> Void){
        
//        Alamofire.upload(multipartFormData: { (multipart) in
//            multipart.append(content.data(using: .utf8)!, withName: "contents")
//            for i in 0..<photos.count {
//                let rotatedImage = photos[i]
//            multipartFormData.append(rotatedImage.jpegData(compressionQuality: 0.5)!, withName: "files",fileName: "rotatedImage.jpg", mimeType: "image/jpg")
//            }, withName: "photo", fileName: "image.jpeg", mimeType: "image/jpeg")}, to: todayURL, headers: uploadDataHeader) { (result) in
//
//            //멀티파트로 성공적으로 인코딩 되었다면 success, 아니라면 failure 입니다.
//            switch result {
//            case .success(let upload, _, _):
//
//                // 성공 하였다면 아래의 과정으로 응답 리스폰스에 대한 처리를 합니다.
//                // 여기부터는 request 함수와 동일합니다.
//                upload.responseObject { (res: DataResponse<ResponseArray<Today_Contents>>) in
//                    switch res.result {
//                    case .success:
//                        completion()
//                    case .failure(let err):
//                        print(err)
//                    }
//                }
//
//            case .failure(let err):
//                print(err)
//            }
//        }
        //
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
