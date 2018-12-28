//
//  LocalDataBase.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 27..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit
import Foundation

// 오늘의 하루 - 게시글 데이터
class TodayBoardData {
    var profileImageData: UIImage
    var profileNameData: String
    var profileDateDate: Date
    
    var boardContentData: UIImage
    var boardPageControlData: Int = 0
    
    var commentImageData: UIImage
    var commentNameData: String
    var commentContentData: String
    var commentCountData: Int

    
    init(pImage : UIImage, pName: String, pDate: Date,
         bContent:UIImage, bPage:Int,
         cImage: UIImage, cName:String, cContent:String, cCount:Int){
        self.profileImageData = pImage
        self.profileNameData = pName
        self.profileDateDate = pDate

        self.boardContentData = bContent
        self.boardPageControlData = bPage

        self.commentImageData = cImage
        self.commentNameData = cName
        self.commentContentData = cContent
        self.commentCountData = cCount
    }
}

// 오늘의 하루 - 댓글 보기 데이터
struct TodayReadData {
    var readImage: UIImage?
    var readName: String
    var readContent: String
    
    init(profile: String,replier: String,memo:String){
        self.readImage = UIImage(named: profile)
        self.readName = replier
        self.readContent = memo
    }
    
}

// 오늘의 하루 - 댓글 작성 데이터
class TodayWriteData {
    
}

// 채팅 - 채팅 내역 데이터
class ChartBoardData {
    
}

// 채팅 - 채팅 작성 데이터
class ChartwriteData {
    
}

// 홈 - 일정 모델
class CalendarModel {
    
}

// 홈 - 일정 데이터
class CalendarData {
    
}

// 홈 - 일정 작성
class CalendarWriteData {
    
}

// 홈 - 일정 알림
class CalendarNoticeData {
    
}

// 더보기 - 더보기 데이터
class PlusData{
    
}
