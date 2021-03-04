//
//  AnniversaryData.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 2..
//  Copyright © 2019년 성다연. All rights reserved.
//

import UIKit
import Foundation


let AnniversaryDateBase = AnniversaryData()

class AnniversaryModel {
    var anniversaryName: String
    var anniversaryDate: String
    var anniversaryDDay: String
    
    init(name:String, date:String, DDay:String) {
        self.anniversaryName = name
        self.anniversaryDate = date
        self.anniversaryDDay = DDay
    }
}


// 임시 데이터
class AnniversaryData {
    var AnniversaryList : [AnniversaryModel] = []
    
    init() {
        let stock = AnniversaryModel(name: "엄마 생일", date: "1970 12 25", DDay: "--")
        let stock2 = AnniversaryModel(name: "아빠 생일", date: "1963 11 20", DDay: "--")
        let stock3 = AnniversaryModel(name: "다연 생일", date: "1997 10 21", DDay: "--")
        
        self.AnniversaryList = [stock, stock2, stock3]
    }
}
