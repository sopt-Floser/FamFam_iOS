//
//  todayCommentCell.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 27..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit
import Foundation

class PostReplyCell: UITableViewCell {

    @IBOutlet weak var replyImage: UIImageView!
    @IBOutlet weak var replyName: UILabel!
    @IBOutlet weak var replyContent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        replyImage.clipsToBounds = true
        replyImage.layer.cornerRadius = replyImage.frame.height/2
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
