//
//  JoinCreateVC.swift
//  flower
//
//  Created by 김지민 on 07/01/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import UIKit

class JoinCreateVC: UIViewController {
    
    @IBOutlet var codeLabel: UILabel!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var timer: UILabel!
    
    var time: Timer?
    var totalTime = 60
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        GroupService.shared.inviteGroup{ jimin in
            guard let jimin2 = jimin.status else {return}
            guard let jimin3 = jimin.data else {return}
            switch jimin2{
            case 200 :
                self.codeLabel.text = jimin3.code!
                print ("아무말")
                self.startOtpTimer()
            case 400 :
                print ("초대코드 생성 실패")
            case 500 :
                print ("서버 내부 에러")
            case 600 :
                print ("DB 에러")
            default :
                print ("그룹 초대 코드 생성/조회")
            }
            
        }
    }

    private func startOtpTimer() {
        self.totalTime = 180
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
                // 00:00 시 다시 인증코드 보내기 아직 안했고, ㅈ금 3분 제한으로 뜸 ㅠ
                
            }
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
}

