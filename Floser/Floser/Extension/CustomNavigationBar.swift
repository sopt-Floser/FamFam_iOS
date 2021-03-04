//
//  CustomNavigationBar.swift
//  flower
//
//  Created by 김지민 on 03/01/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationBar {
    @IBInspectable var customHeight : CGFloat = 63
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: customHeight)
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        for subview in self.subviews {
            var stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("UIBarBackground") {
                subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight)
                subview.sizeToFit()
            }
            
            stringFromClass = NSStringFromClass(subview.classForCoder)
            
            //Can't set height of the UINavigationBarContentView
            if stringFromClass.contains("UINavigationBarContentView") {
                //Set Center Y
                let centerY = (customHeight - subview.frame.height) / 2.0
                subview.frame = CGRect(x: 0, y: centerY, width: self.frame.width, height: subview.frame.height)
                subview.sizeToFit()
                
            }
        
            stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarContent") {
                subview.frame = CGRect(x: subview.frame.origin.x, y: 20, width: subview.frame.width, height: customHeight)
                subview.backgroundColor = self.backgroundColor
            }
        }
    }
}
