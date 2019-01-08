//
//  CalendarService.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 7..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import Alamofire

struct CalendarService: APIManager, Requestable {
    typealias NetworkData = ResponseObject<Calendar_Month>
    static let shared = CalendarService()
    let calendarURL = url("/calendar")
    let header: HTTPHeaders = [
        "Content-Type": "application/json"
    ]
    let uploadHeaders: HTTPHeaders = [
        "Content-Type": "application/json",
        "Authorization": UserDefaults.standard.string(forKey: "token") ?? "no Token"
    ]
    
    
    
    // 월별 일정 조회 api
    func getCalendarMonthList(dateStr:String? = "" , completion: @escaping (NetworkData) -> Void){
        let queryURL = calendarURL + "/month/\(dateStr)"
        
        get(queryURL, body: nil, header: uploadHeaders){ (res) in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
    }
    
    
    // 일별 일정 조회 api
    func getCalendarDayList(dateStr:String? = "", completion: @escaping (NetworkData) -> Void){
        let queryURL = calendarURL + "/oneday/\(dateStr)"
        
        get(queryURL, body: nil, header: uploadHeaders){ (res) in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
        
    }
    
   
    // 일정 검색 api
    func getCalendarSearchList(content:String, completion: @escaping(NetworkData) -> Void){
        let queryURL = calendarURL + "/search"
        
        let body = [
            "content" : content
        ]
        get(queryURL, body: body, header: uploadHeaders){ (res) in
            switch res {
            case .success(let value):
                completion(value)
            case .error(let error):
                print(error)
            }
        }
    }
    
    // 가족 & 개인 일정 추가
    func addCalendarTodo(calendarType:Int?, startDate:String?, endDate: String?, content: String?, returningTime:Int?, dinner: Int?, completion: @escaping(NetworkData) -> Void){
        let queryURL = calendarURL + "/\(calendarType)"
        
        let body = [
            "startDate" : startDate, // 일정 시작일
            "endDate" : endDate, // 일정 종료일
            "content" : content, // 일정 내용
            "returningTime" : returningTime, // 개인 귀가시간
            "dinner" : dinner // 개인 저녁 식사 여부
            ] as [String : Any]
        
        post(queryURL, body: body, header: uploadHeaders){ res in
            switch res {
            case .success(let value):
                print("일정 추가 완료")
                completion(value)
            case .error(let error):
                print("일정 추가 실패")
                completion(error)
            }
        }
    }
    
    // 개인 & 가족 일정 수정
    func editCalendarTodo(calendarType:Int? = 0, calendarIdx:Int? = 0, startDate:String?, endDate: String?, content: String?, returningTime:Int?, dinner: Int?, completion: @escaping(NetworkData) -> Void){
        let queryURL = calendarURL + "/\(calendarType)/\(calendarIdx)"
        
        let body = [
            "startDate" : startDate, // 일정 시작일
            "endDate" : endDate, // 일정 종료일
            "content" : content, // 일정 내용
            "returningTime" : returningTime, // 개인 귀가시간
            "dinner" : dinner // 개인 저녁 식사 여부
            ] as [String : Any]
        
        put(queryURL, body: body, header: uploadHeaders){ res in
            switch res {
            case .success(let value):
                print("일정 수정 완료")
                completion(value)
            case .error(let error):
                print("일정 수정 실패")
                completion(error)
            }
        }
        
    }
    
    // 개인 & 가족 일정 삭제
    func deleteCalendarTodo(calendarType:Int? = 0, calendarIdx:Int? = 0, completion:@escaping(NetworkData) -> Void){
        let queryURL = calendarURL + "/\(calendarType)/\(calendarIdx)"
        
        delete(queryURL, body: nil, header: uploadHeaders){ res in
            switch res {
            case .success(let value):
                print("일정 삭제 완료")
                completion(value)
            case .error(let error):
                print("일정 삭제 실패")
                completion(error)
            }
        }
    }
    
    
}
