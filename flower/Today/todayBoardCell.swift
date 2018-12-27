//
//  todayBoardCell.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 27..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit
import Foundation

class todayBoardCell: UITableViewCell {
    // 상단 (프로필)
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileDate: UILabel!
    
    // 중간 (게시글)
    @IBOutlet weak var boardContent: UIImageView!
    @IBOutlet weak var boardPagecontrol: UIPageControl!
    @IBAction func emotionBtn(_ sender: Any) {
    }
    
    //하단 (댓글)
    @IBAction func commentBtn(_ sender: Any) {
    }
    @IBOutlet weak var commentImage: UIImageView!
    @IBOutlet weak var commentName: UILabel!
    @IBOutlet weak var commentContent: UILabel!
    @IBOutlet weak var commentCount: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
