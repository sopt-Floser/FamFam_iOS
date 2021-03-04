//
//  InviteCodeVC.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 3..
//  Copyright © 2019년 성다연. All rights reserved.
//

import UIKit

var groupInviteCode : String?
var totalTime = 600
var timerIsWork = false

class InviteCodeVC: UIViewController {
    @IBOutlet weak var inviteCodeLabel: UILabel!
    @IBOutlet weak var inviteTimerLabel: UILabel!
    @IBAction func completeBtn(_ sender: UIButton) {
        timerIsWork = false
        dismiss(animated: true, completion: nil)
    }
    
    var time: Timer?
    
    var tempDate = Date()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("timerCount = \(timerIsWork)")
        joinCode()
        var date = Date() // 현재 시간
    }
    
    func getExpireTime(expire:String){
        let expireDate = dateformatting(value: expire)
        let date = Date()
        let calendar = NSCalendar.current
        let components = calendar.component(.second, from: date)
    }
    
    func dateformatting(value:String) -> Date{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss"
        return dateFormatter.date(from: value) ?? Date()
    }
    
    private func startOtpTimer() {
        if totalTime == 0 {
            totalTime = 600
        }
        if (timerIsWork == false){
            self.time = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            timerIsWork = true
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @objc func updateTimer() {
        self.inviteTimerLabel.text = self.timeFormatted(totalTime)
        
        if (timerIsWork == true){
            if totalTime != 0 {
                totalTime -= 1
            } else {
                if let time = self.time {
                    time.invalidate()
                    self.time = nil
                    timerIsWork = false
                    // 00:00 시 다시 인증코드 보내기
                }
            }
        }
        else {
                self.time?.invalidate()
            }
    }
    
    func joinCode(){
        GroupService.shared.inviteGroup{ res in
            guard let status = res.status else {return}
            guard let data = res.data?.code else {return}
            guard let expiredate = res.data?.expiredAt else {return} // 만료 시간
            
            
            switch status {
            case 200 :
                groupInviteCode = data
                self.inviteCodeLabel.text = data
                self.getExpireTime(expire: expiredate)
                    self.startOtpTimer()
                print("그룹 초대 코드 조회 성공")
            case 204 :
                print("참여된 그룹이 없습니다")
            case 404:
                print("회원을 찾을 수 없습니다")
            case 500:
                print("서버 내부 에러")
            case 600 :
                print("DB 에러")
            default:
                print("그룹 참여 코드 조회중")
            }
        }
    }
   
}
