//
//  myChatCell.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 4..
//  Copyright © 2019년 성다연. All rights reserved.
//

import UIKit

class MyChatCell: UITableViewCell {
    @IBOutlet weak var myChatMessage: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
