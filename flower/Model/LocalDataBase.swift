//
//  LocalDataBase.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 27..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit
import Foundation

/** 오늘의 하루 - 게시글 데이터 */
class TodayBoardData {
    var profileImageData: UIImage
    var profileNameData: UILabel
    var profileDateDate: Date
    
    var boardContentData: UIImage
    var boardPageControlData: Int
    
    var commentImageData: UIImage
    var commentNameData: UILabel
    var commentContentData: UILabel
    var commentCountData: Int

    init(pImage : UIImage, pName: String, pDate: Date,
         bContent:UIImage, bPage:Int,
         cImage: UIImage, cName:String, cContent:String, cCount:Int){
        self.profileImageData = pImage
        self.profileNameData.text = pName
        self.profileDateDate = pDate
        
        self.boardContentData = bContent
        self.boardPageControlData = bPage
        
        self.commentImageData = cImage
        self.commentNameData.text = cName
        self.commentContentData.text = cContent
        self.commentCountData = cCount
    }
}

// 오늘의 하루 - 댓글 보기 데이터
class TodayReadData {
    
}

// 오늘의 하루 - 댓글 작성 데이터
class TodayWriteData {
    
}

class ChartBoardData {
    
}

// 
class ChartwriteData {
    
}

// 캘린더 모델
class CalendarModel {
    
}

// 달력 데이터
class CalendarData {
    
}

// 캘린더 작성
class CalendarWriteData {
    
}

// 캘린더 알림
class CalendarNoticeData {
    
}

// 더보기
class PlusData{
    
}
