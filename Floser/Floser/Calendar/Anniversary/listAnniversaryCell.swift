//
//  listAnniversaryCell.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 1..
//  Copyright © 2019년 성다연. All rights reserved.
//

import UIKit

class listAnniversaryCell: UITableViewCell {
    @IBOutlet weak var anniversaryName: UILabel!
    @IBOutlet weak var anniversaryDate: UILabel!
    @IBOutlet weak var anniversaryDDay: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
