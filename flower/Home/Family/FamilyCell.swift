//
//  FamilyCell.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 27..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit

class FamilyCell: UICollectionViewCell {
    @IBOutlet weak var familyImage: UIImageView!
    @IBOutlet weak var familyName: UILabel!
    @IBOutlet weak var familyBackView: UIView!
 
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        familyBackView.layer.cornerRadius = 25
        familyBackView.layer.shadowRadius = 1
        familyBackView.layer.shadowOpacity = 0.12
        familyBackView.layer.shadowOffset = CGSize(width: 3, height: 5)
        familyBackView.clipsToBounds = false
        
        familyImage.layer.masksToBounds = true
        familyImage.layer.cornerRadius = 25
    
        self.sizeThatFits(CGSize(width: self.frame.width, height: self.frame.height))
    }

}
