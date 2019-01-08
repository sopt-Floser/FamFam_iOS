//
//  weekCalendarCell.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 28..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit

class missionCell: UICollectionViewCell {
    @IBOutlet weak var missionPerson: UILabel!
    @IBOutlet weak var missionLabel: UILabel!
    @IBOutlet weak var missionImage: UIImageView!
    
    
    /** 효과 씌우기 */
    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = 15
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 10)
        self.clipsToBounds = false
    }
}
