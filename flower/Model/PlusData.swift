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
