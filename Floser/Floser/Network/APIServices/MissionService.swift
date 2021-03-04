//
//  MissionService.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 11..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import Alamofire

struct MissionService : APIManager, Requestable{
    typealias  NetworkData = ResponseObject<MissionModel>
    static let shared = MissionService()
    let missionURL = url("/mission")
    let header : HTTPHeaders = [
        "Authorization": UserDefaults.standard.string(forKey: "token") ?? "no Token"
    ]
    
    func getMission(completion:@escaping(NetworkData)->Void){
        get(missionURL, body: nil, header: header){ res in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let value):
                completion(value)
            }
        }
    }
}
