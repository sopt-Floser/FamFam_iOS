//
//  PlusVersionInfoVC.swift
//  flower
//
//  Created by 김지민 on 02/01/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import UIKit

var myPlusVersionArray:[PlusVersionData] = []
class PlusVersionVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPlusVersionData()
        setPlusVersionData()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet var versionStatus: UILabel!
    @IBOutlet var currentVersion: UILabel!
    
    
    
    
    
    @IBOutlet var latestVersion: UILabel!
    
    func setPlusVersionData() {
        let myPlus = myPlusVersionArray[0]
        
        self.currentVersion.text = myPlus.currentVersion
        self.latestVersion.text = myPlus.latestVersion
        
        if currentVersion == latestVersion {
            versionStatus.text = "현재 최신 버전입니다"
        } else {
            versionStatus.text = "업데이트가 필요합니다."
        }
        
    }
}

extension PlusVersionVC {
    func getPlusVersionData(){
        let myPlusVersionData = PlusVersionData(currentVs: "1.2.3", latestVs: "2.0.0")
        myPlusVersionArray = [myPlusVersionData]
    }
}
