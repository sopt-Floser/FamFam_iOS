//
//  todayBoardCell.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 27..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit
import Foundation

class todayPostCell: UITableViewCell {
    // 상단 (프로필)
    @IBOutlet var postProfileImage: UIImageView!
    @IBOutlet var postName: UILabel!
    @IBOutlet var postDate: UILabel!
    
    // 중간 (게시글)
    @IBOutlet var postImage: UIImageView!
    @IBOutlet var postImagePagecontrol: UIPageControl!
    

    
    // 중간 (감정)
    @IBAction func emotionAddBtn(_ sender: Any) {
    }
    @IBOutlet var emotionImage: UIImageView!
    @IBOutlet var emotionName: UILabel!
    

    //중간 (게시글)
    @IBOutlet weak var postContent: UILabel!
    
    //하단 (댓글)
    
    @IBAction func replyShow(_ sender: Any) {
    }
    @IBOutlet weak var replyCount: UILabel!
    
    //
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
