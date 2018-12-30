//
//  todayFullPostCell.swift
//  flower
//
//  Created by 김지민 on 29/12/2018.
//  Copyright © 2018 성다연. All rights reserved.
//

import UIKit

class PostFullCell: UITableViewCell {
    
    
    @IBOutlet var postProfileImageView: UIImageView!
    @IBOutlet var postNameView: UILabel!
    @IBOutlet var postDateView: UILabel!
    @IBOutlet var postImageView: UIImageView!
    
    @IBOutlet var postImagePageControlView: UIPageControl!
    
    
    @IBAction func emotionAddBtn(_ sender: Any) {
    }
    
    @IBOutlet var emotionImageView: UIImageView!
    @IBOutlet var emotionNameView: UILabel!
    
    @IBOutlet var postContentView: UILabel!
    
    @IBOutlet var replyCountView: UILabel!
    @IBAction func replyShowBtn(_ sender: Any) {
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
