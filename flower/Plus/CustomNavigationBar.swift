//
//  CustomNavigationBar.swift
//  flower
//
//  Created by 김지민 on 03/01/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import UIKit

class CustomNavigationBar: UINavigationBar {
    
    // NavigationBar height
    var customHeight : CGFloat = 63
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: customHeight)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let y = UIApplication.shared.statusBarFrame.height
        frame = CGRect(x: frame.origin.x, y:  y, width: frame.size.width, height: customHeight)
        
        for subview in self.subviews {
            var stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarBackground") {
                subview.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: customHeight)
                subview.backgroundColor = self.backgroundColor
            }
            
            stringFromClass = NSStringFromClass(subview.classForCoder)
            if stringFromClass.contains("BarContent") {
                subview.frame = CGRect(x: subview.frame.origin.x, y: 20, width: subview.frame.width, height: customHeight)
                subview.backgroundColor = self.backgroundColor
            }
        }
    }
}
