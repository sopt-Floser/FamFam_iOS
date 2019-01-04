//
//  OtherChatCell.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 4..
//  Copyright © 2019년 성다연. All rights reserved.
//

import UIKit

class OtherChatCell: UITableViewCell {
    @IBOutlet weak var otherChatImage: UIImageView!
    @IBOutlet weak var otherChatName: UILabel!
    @IBOutlet weak var otherChatMessage: UILabel!
    @IBOutlet weak var otherChatBackView: UIView!
    
    override func layoutSubviews() {
        otherChatBackView.layer.cornerRadius = 25
        otherChatBackView.layer.shadowRadius = 1
        otherChatBackView.layer.shadowOpacity = 0.12
        otherChatBackView.layer.shadowOffset = CGSize(width: 3, height: 5)
        
        otherChatImage.clipsToBounds = false
        otherChatImage.cornerRadius = 25
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
