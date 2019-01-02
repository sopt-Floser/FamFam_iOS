//
//  genderSelection.swift
//  flower
//
//  Created by 김지민 on 02/01/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import UIKit

class genderSelection: UIButton {
    
    var buttonArray:Array<genderSelection>?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        selectJudge()
        super.touchesBegan(touches, with: event)
    }
    
    func selectJudge(){
            self.isSelected = true
            for otherBtn:genderSelection in buttonArray! {
                otherBtn.isSelected = false
            }
    }

    override var isSelected: Bool {
        didSet{
            if isSelected {
                self.layer.borderColor = UIColor(red: 54, green: 108, blue: 226, alpha: 1.0).cgColor
            } else {
                self.layer.borderColor = UIColor(red: 112, green: 112, blue: 112, alpha: 1.0).cgColor
            }
        }
    }
}
