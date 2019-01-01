//
//  CalendarData.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 1..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation

let CalendarDatabase = CalendarData()

// 홈 - 일정 모델
class CalendarModel {
    var date: String
    var memo: String
    var color: String
    
    init(date:String, memo:String, color:String) {
        self.date = date
        self.memo = memo
        self.color = color
    }
}

// 홈 - 일정 데이터
class CalendarData {
    var CalendarDataArray: [CalendarModel] = []
    var CalendarDateArray: [String] = []
    
    init(){
        let stock = CalendarModel(date: "2019 01 02", memo: "합숙", color: "blue")
        let stock2 = CalendarModel(date: "2019 01 05", memo: "서버 연동", color: "green")
        let stock3 = CalendarModel(date: "2019 01 06", memo: "에어비엔비", color: "black")
        let stock4 = CalendarModel(date: "2019 01 08", memo: "와우", color: "gray")
        let stock5 = CalendarModel(date: "2019 01 10", memo: "오버워치", color: "orange")
        self.CalendarDataArray = [stock, stock2, stock3, stock4, stock5]
        self.CalendarDateArray = [stock.date, stock2.date, stock3.date, stock4.date, stock5.date]
    }
}
