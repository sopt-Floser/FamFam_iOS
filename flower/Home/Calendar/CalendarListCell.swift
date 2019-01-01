//
//  CalendarListCell.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 1..
//  Copyright © 2019년 성다연. All rights reserved.
//

import UIKit
import Foundation

class CalendarListCell: UITableViewCell {

    @IBOutlet weak var listName: UILabel!
    @IBOutlet weak var listColor: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
