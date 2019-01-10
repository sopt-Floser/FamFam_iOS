//
//  LaunchVC.swift
//  flower
//
//  Created by 김지민 on 08/01/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import UIKit
import Lottie

class LaunchVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = LOTAnimationView(name: "splash_3second 2")
            animationView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width , height: 800)
            animationView.center = self.view.center
            animationView.contentMode = .scaleAspectFill
        
            view.addSubview(animationView)
            
        animationView.play { (finish) in
            if finish {
                
            }
        }
    }
}
