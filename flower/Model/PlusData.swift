//
//  PlusData.swift
//  flower
//
//  Created by 김지민 on 02/01/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import Foundation

//더보기 첫화면 데이터

class PlusData {
    
    
    var plusBackPic: String? //UIImage?
    var profilePic: String? //UIImage?
    var myName: String
    var myIntroduce: String
    var myVersionInfo: String
    
    
    init(backPic : String, profilePic: String, name: String,
         introduce:String, version:String){
        self.plusBackPic = backPic //UIImage(named: pPImage)
        self.profilePic = profilePic //UIImage(named:pImage)
        self.myName = name
        self.myIntroduce = introduce
        self.myVersionInfo = version
    
    }
}

// 더보기 버전 정보 데이터

class PlusVersionData {
    var currentVersion: String
    var latestVersion: String
    
    init(currentVs : String, latestVs : String){
        self.currentVersion = currentVs
        self.latestVersion = latestVs
    }
    
}

// 더보기 프로필 편집 데이터

// 더보기 계정 보안 데이터

// 더보기 알람 데이터
