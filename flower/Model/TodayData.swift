//
//  TodayData.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 1..
//  Copyright © 2019년 성다연. All rights reserved.
//

import UIKit
import Foundation

class TodayFeedData {
    var postProfileImage: String? //UIImage?
    var postName: String
    var postDate: String //date로 바꿔야함
    
    var postImage: String? //UIImage?
    var postImagePagecontrol: Int
    
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
class PostReplyData {
    var replyImage: String? //UIImage?
    var replyName: String
    var replyContent: String
    
    init(profile: String,replier: String,comment:String){
        self.replyImage = profile
        self.replyName = replier
        self.replyContent = comment
    }
}
