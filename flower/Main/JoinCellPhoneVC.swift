//
//  JoinCellPhoneVC.swift
//  flower
//
//  Created by 김지민 on 30/12/2018.
//  Copyright © 2018 성다연. All rights reserved.
//

import UIKit
import Firebase

var phoneNumber:String?

class JoinCellPhoneVC: UIViewController {
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var codeTF: UITextField!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var reAskBtn: UIButton!
    @IBOutlet weak var bottomBtn: UIButton!
    @IBOutlet weak var timer: UILabel!
    
    var time: Timer?
    var totalTime = 60
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        phoneTF.becomeFirstResponder()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO - 번호인지 확인하는 함수 들어가야함
        if (phoneTF.text!.count > 10){
        bottomBtn.addTarget(self, action: #selector(changeButton), for: .touchUpInside)
        }

    }
}

extension JoinCellPhoneVC {
   
    
    private func startOtpTimer() {
        self.totalTime = 60
        self.time = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        self.timer.text = self.timeFormatted(self.totalTime)
        if totalTime != 0 {
            totalTime -= 1
        } else {
            if let time = self.time {
                time.invalidate()
                self.time = nil
            }
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @objc func changeButton(){
        bottomBtn.setTitle("입력 완료", for: .normal)
        codeView.isHidden = false
        startOtpTimer()
        timer.isHidden = false
        timeLabel.isHidden = false
        timeLabel.text = "분 내 미입력시 재인증하셔야합니다."
        reAskBtn.isHidden = false
        if (phoneTF.text!.count > 11) {
            bottomBtn.setTitle("완료", for: <#T##UIControl.State#>)
        }
    }
    
    @objc func clearAuthor(){
        
    }
}
