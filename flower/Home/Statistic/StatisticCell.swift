//
//  StatisticCell.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 27..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit

class StatisticCell: UICollectionViewCell {
    @IBOutlet weak var allLoveCountLabel: UILabel!
    @IBOutlet weak var didLoveCountLabel: UILabel!
    @IBOutlet weak var newPicCountLabel: UILabel!
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBAction func goCameraBtn(_ sender: Any) {
    }
    
    /** 효과 씌우기 */
    override func layoutSubviews() {
        super.layoutSubviews()
        self.clipsToBounds = false
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 10)
        
        
        backgroundImage.layer.masksToBounds = true
        backgroundImage.layer.cornerRadius = 15
    }
}
