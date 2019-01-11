//
//  userAgreementVC.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 10..
//  Copyright © 2019년 성다연. All rights reserved.
//

import UIKit

class userAgreementVC: UIViewController {
    var delegate2: sendBtn2DataDelegate?
    
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func agreedBtn(_ sender: UIButton) {
        delegate2?.sendData2(data: true)
        print("send data2")
        dismiss(animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}
