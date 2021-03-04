//
//  Requestable.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 3..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireObjectMapper
import ObjectMapper

protocol Requestable {
    associatedtype NetworkData: Mappable
}

//Request 함수를 재사용하기 위한 프로토콜입니다.

extension Requestable {
    //서버에 get 요청을 보내는 함수
    func get(_ url: String, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (NetworkResult<NetworkData>) -> Void) {
        
        AF.request(url, method: .get, parameters: body, encoding: JSONEncoding.default, headers: header).responseData { res in
            switch res.result {
            case .success:
                guard let value = res.value else { return }
                completion(.success(value as! Self.NetworkData))
            case .failure:
                guard let value = res.value else { return }
                completion(.error(value as! Self.NetworkData))
            }
        }
    }
    
    //서버에 post 요청을 보내는 함수
    func post(_ url: String, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (NetworkResult<NetworkData>) -> Void) {
        AF.request(url, method: .post, parameters: body, encoding: JSONEncoding.default, headers: header).responseData { res in
            switch res.result {
            case .success:
                guard let value = res.value else { return }
                completion(.success(value as! Self.NetworkData))
            case .failure:
                guard let value = res.value else { return }
                completion(.error(value as! Self.NetworkData))
            }
        }
    }
    
    func put(_ url: String, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (NetworkResult<NetworkData>) -> Void) {
        AF.request(url, method: .put, parameters: body, encoding: JSONEncoding.default, headers: header).responseData { res in
            switch res.result {
            case .success:
                guard let value = res.value else { return }
                completion(.success(value as! Self.NetworkData))
            case .failure:
                guard let value = res.value else { return }
                completion(.error(value as! Self.NetworkData))
            }
        }
    }
    
    func delete(_ url: String, body: [String:Any]?, header: HTTPHeaders?, completion: @escaping (NetworkResult<NetworkData>) -> Void) {
        AF.request(url, method: .delete, parameters: body, encoding: JSONEncoding.default, headers: header).responseData { res in
            switch res.result {
            case .success:
                guard let value = res.value else { return }
                completion(.success(value as! Self.NetworkData))
            case .failure:
                guard let value = res.value else { return }
                completion(.error(value as! Self.NetworkData))
            }
        }
    }
}
