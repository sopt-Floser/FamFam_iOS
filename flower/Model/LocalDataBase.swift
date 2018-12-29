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
struct TodayFeedData {
    var postProfileImage: String? //UIImage?
    var postName: String
    var postDate: String //date로 바꿔야함
    
    var postImage: String? //UIImage?
    var postImagePagecontrol: Int = 0
    
    
    
    var emotionImage: String? //UIImage?
    var emotionName: String
    
    var postContent: String
    
    var replyCount: Int

    
    init(pPImage : String, pName: String, pDate: String,
         pImage:String, pPage:Int,
         eImage: String, eName:String, pContent:String, rCount:Int){
        self.postProfileImage = pPImage//UIImage(named: pPImage)
        self.postName = pName
        self.postDate = pDate

        self.postImage = pImage //UIImage(named:pImage)
        self.postImagePagecontrol = pPage

        self.emotionImage = eImage //UIImage(named:eImage)
        self.emotionName = eName
        self.postContent = pContent
        self.replyCount = rCount
    }
}

// 오늘의 하루 - 댓글 보기 데이터
struct PostReplyData {
    var replyImage: UIImage?
    var replyName: String
    var replyContent: String
    
    init(profile: String,replier: String,memo:String){
        self.replyImage = UIImage(named: profile)
        self.replyName = replier
        self.replyContent = memo
    }
    
}

// 오늘의 하루 - 댓글 작성 데이터
class PostNewReplyData {
    
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
