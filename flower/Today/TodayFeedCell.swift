//
//  todayBoardCell.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 27..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit
import Foundation



class TodayFeedCell: UITableViewCell {
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundProfileImage() //프로필 이미지 둥글게
        cropPostImage() //게시글 이미지 위아래 커트
        // Initialization code
    }
    
    // 상단 (프로필)
    @IBOutlet var postProfileImage: UIImageView?
    func roundProfileImage(){
        postProfileImage?.clipsToBounds = true
        postProfileImage?.layer.cornerRadius = (postProfileImage?.frame.height)!/2
    }
    
    @IBOutlet var postName: UILabel!
    @IBOutlet var postDate: UILabel!
    
    // 중간 (게시글)
    @IBOutlet var postImage: UIImageView?
    func cropPostImage(){
        postImage?.layer.masksToBounds = true
        postImage?.clipsToBounds = true
    }
    
    @IBOutlet var postImagePagecontrol: UIPageControl!

    // 중간 (감정)
    @IBAction func emotionAddBtn(_ sender: Any) {
    }
    @IBOutlet var emotionImage: UIImageView?
    @IBOutlet var emotionName: UILabel!
    

    //중간 (게시글)
    @IBOutlet weak var postContent: UILabel!
    
    //하단 (댓글)
    
  
   
    
    @IBOutlet weak var replyCount: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
