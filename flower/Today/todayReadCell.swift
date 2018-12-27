//
//  todayCommentCell.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 27..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit
import Foundation

class todayReadCell: UITableViewCell {

    @IBOutlet weak var readImage: UIImageView!
    @IBOutlet weak var readName: UILabel!
    @IBOutlet weak var readContent: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
