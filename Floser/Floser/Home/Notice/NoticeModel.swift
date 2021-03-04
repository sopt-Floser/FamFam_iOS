//
//  File.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 28..
//  Copyright © 2018년 성다연. All rights reserved.
//

import Foundation
import UIKit

struct NoticeModel {
    var noticeImage: UIImage?
    var noticeLabel: String
    
    init(noticeImage:String, noticeLabel: String){
        self.noticeImage = UIImage(named: noticeImage)
        self.noticeLabel = noticeLabel
    }
}
