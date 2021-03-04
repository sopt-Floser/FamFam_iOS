//
//  CalendarData.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 1..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation

let CalendarDatabase = CalendarData()

// 일정 할일 데이터 간략화 시 사용
enum anniversary:String {
    case birth = "생일"
    case marriage = "결혼"
    case other = "기타"
}
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

    init(){
        CalendarDataArray = setDefaultData()
    }
    
    private func setDefaultData() -> [CalendarModel] {
        let stock = CalendarModel(date: "2019 01 02", memo: "합숙", color: "#eeclad")
        let stock2 = CalendarModel(date: "2019 01 05", memo: "서버 합동", color: "#8eedd6")
        let stock3 = CalendarModel(date: "2019 01 06", memo: "에어비엔비", color: "#367bf0")
        let stock4 = CalendarModel(date: "2019 01 09", memo: "와우", color: "#fea2ab")
        let stock5 = CalendarModel(date: "2019 01 12", memo: "오버워치", color: "#525c68")
        let stock6 = CalendarModel(date: "2019 01 24", memo: "라면 데이", color: "#3644f9")
        return [stock, stock2, stock3, stock4, stock5, stock6]
    }
}
