//
//  JoinCellPhoneVC.swift
//  flower
//
//  Created by 김지민 on 30/12/2018.
//  Copyright © 2018 성다연. All rights reserved.
//

import UIKit
import FirebaseAuth


class JoinCellPhoneVC: UIViewController {
    @IBOutlet weak var phoneTF: UITextField!
    @IBOutlet weak var codeView: UIView!
    @IBOutlet weak var codeTF: UITextField!
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var reAskBtn: UIButton!
    @IBOutlet weak var bottomBtn: UIButton!
    @IBOutlet weak var timer: UILabel!
    
    var sendPhoneNumber:SignUpPhoneNumber?
    var phoneNumber:String? // 프로토콜 안먹혀서 임시로 전역변수로 씀
    var time: Timer?
    var totalTime = 60
    var verificationID : String?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        phoneTF.becomeFirstResponder()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO - 번호인지 확인하는 함수 들어가야함
        
        bottomBtn.addTarget(self, action: #selector(changeButton), for: .touchUpInside)
        reAskBtn.addTarget(self, action: #selector(resetAsking), for: .touchUpInside)
    }
    
}

extension JoinCellPhoneVC {
    func test(){
        
        verificationID = "111111"
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneTF.text!, uiDelegate: nil ){ (verificationID, error) in
            if error != nil {
                print("error\(String(describing: error?.localizedDescription))")
            } else {
                let defaults = UserDefaults.standard
                defaults.set(verificationID, forKey: "autoVID")
            }
        }
        //Auth.auth().languageCode = "kr"
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
                // 00:00 시 다시 인증코드 보내기
                resetAsking()
            }
        }
    }
    @objc func resetAsking(){
        startOtpTimer()
        test()
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @objc func changeButton(){
        bottomBtn.setTitle("입력 완료", for: .normal)
        codeView.isHidden = false
        test()
        startOtpTimer()
        timer.isHidden = false
        timeLabel.isHidden = false
        timeLabel.text = "분 내 미입력시 재인증하셔야합니다."
        reAskBtn.isHidden = false
        
//        let defaults = UserDefaults.standard
//        let credential : PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: defaults.string(forKey: "autoVID")!, verificationCode:  codeTF.text!)
//            Auth.auth().signInAndRetrieveData(with: credential){ (user, error) in
//                if error != nil {
//                    print("error\(String(describing: error?.localizedDescription))")
//                } else {
//                   print("phoneNum")
//                }
//        }
     
        if (codeTF.text! == verificationID){
            bottomBtn.setTitle("완료", for: .normal)
            timeLabel.isHidden = true
            timer.isHidden = true
            reAskBtn.isHidden = true
            codeTF.isEnabled = false
            bottomBtn.addTarget(self, action: #selector(clearAuthor), for: .touchUpInside)
            print("same code")
            
            sendPhoneNumber?.userPhoneNumber(PhoneNumber: phoneTF.text!)
        }
    }
    
    @objc func clearAuthor(){
        let dvc = storyboard?.instantiateViewController(withIdentifier: "signupWriteStoryboard") as! JoinPersonalInfoVC
        present(dvc, animated: true)
    }
}
