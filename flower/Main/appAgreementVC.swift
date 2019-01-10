//
//  appAgreementVC.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 10..
//  Copyright © 2019년 성다연. All rights reserved.
//

import UIKit

class appAgreementVC: UIViewController {
    var delegate1:sendBtnDataDelegate?
    
    @IBOutlet weak var agreeBtn: UIButton!
    @IBAction func backBtn(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        agreeBtn.addTarget(self, action: #selector(btnStatus), for: .touchUpInside)
    }

    @objc func btnStatus(){
        dismiss(animated: true)
        if agreeBtn.titleLabel?.text == "동의하기" {
            agreeBtn.setTitle("동의하지 않음", for: .normal)
            delegate1?.sendData(data: true)
        } else {
            agreeBtn.setTitle("동의하기", for: .normal)
            delegate1?.sendData(data: false)
        }
    }
}
