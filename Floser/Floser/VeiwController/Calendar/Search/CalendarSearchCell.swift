//
//  CalendarSearchCell.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 2..
//  Copyright © 2019년 성다연. All rights reserved.
//

import UIKit
import Foundation

class CalendarSearchCell: UITableViewCell {
    @IBOutlet weak var searchDate: UILabel!
    @IBOutlet weak var searchLunarDate: UILabel!
    @IBOutlet weak var searchMemo: UILabel!
    @IBOutlet weak var searchColor: UIView!
    
    override func awakeFromNib() {
        searchColor.cornerRadius = 4
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
