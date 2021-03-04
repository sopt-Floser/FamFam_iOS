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

    @IBOutlet var logoImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let animationView = LOTAnimationView(name: "splash_ios")
            animationView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width , height: 600)
            animationView.center = self.view.center
            animationView.contentMode = .scaleAspectFit
        
            view.addSubview(animationView)
        
        logoImage.frame = CGRect(x: 0, y: 0, width: self.view.frame.width - 10, height: 590)
        logoImage.center = self.view.center
        logoImage.contentMode = .scaleAspectFit
        logoImage.layer.zPosition = 1

            
        animationView.play { (finish) in
            if finish {
                print("끝")
                let appDelegate = UIApplication.shared.delegate! as! AppDelegate
                let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "IntroduceVC")
                appDelegate.window?.rootViewController = initialViewController
                appDelegate.window?.makeKeyAndVisible()
            }
        }

    }
}

