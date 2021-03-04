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
    var phoneNumber:String? 
    var time: Timer?
    var totalTime = 600
    
    var timerIsWork2 = false
    
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
        // 전화번호 인증코드 보내기
        let defaults = UserDefaults.standard
        let testVerificationCode : String = String(UInt32(arc4random_uniform(1000000)))
        
        print("test Num = \(testVerificationCode)")
        Auth.auth().settings?.isAppVerificationDisabledForTesting = true
        
        PhoneAuthProvider.provider().verifyPhoneNumber(self.phoneTF.text!, uiDelegate:nil) {
            verificationID, error in
            if (error != nil) {
                // Handles error
                
                ToastView.shared.short(self.view, txt_msg: "인증번호를 요청했습니다.")
                return
            }
            guard let verificationID = verificationID else { return }
            print("verificationID = \(verificationID)")
             // TODO: get SMS verification code from user.
            if let verificationCode = self.codeTF.text {
                let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: verificationCode)
                Auth.auth().signIn(with: credential) { (user, error) in
                    UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
                }
            } else {
                ToastView.shared.short(self.view, txt_msg: "인증번호가 다릅니다.")
            }
            
        };
        Auth.auth().languageCode = "kr"
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
        if (timerIsWork2 == false){
            self.time = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
            timerIsWork2 = true
        }
    }
    
    func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    @objc func updateTimer() {
        self.timer.text = self.timeFormatted(totalTime)
        
        if (timerIsWork2 == true){
            if totalTime != 0 {
                totalTime -= 1
            } else {
                if let time = self.time {
                    time.invalidate()
                    self.time = nil
                    timerIsWork2 = false
                    // 00:00 시 다시 인증코드 보내기
                }
            }
        }
        else {
            self.time?.invalidate()
        }
    }
    
    @objc func resetAsking(){
        startOtpTimer()
        test()
    }
    
    
    
    @objc func changeButton(){
        if (phoneTF.text != ""){
            bottomBtn.setTitle("입력 완료", for: .normal)
            codeView.isHidden = false
            //test()
            startOtpTimer()
            timer.isHidden = false
            timeLabel.isHidden = false
            timeLabel.text = "분 내 미입력시 재인증하셔야합니다."
            reAskBtn.isHidden = false
            bottomBtn.addTarget(self, action: #selector(clearAuthor), for: .touchUpInside)
        }
    }
    
    
    
    @objc func clearAuthor(){
        
        // 인증코드 맞는지 확인
        let defaults = UserDefaults.standard
        
        let verificationID = UserDefaults.standard.string(forKey: "authVerificationID")
        
        let credential : PhoneAuthCredential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID ?? "no verificationID", verificationCode:  codeTF.text!)
        

//        Auth.auth().signInAndRetrieveData(with: credential){ (user, error) in
//            if error != nil {
//                print("error\(String(describing: error?.localizedDescription))")
//            } else {
//
//                print("phoneNum = \(self.phoneTF.text)")
//                self.bottomBtn.setTitle("완료", for: .normal)
//                self.timeLabel.isHidden = true
//                self.timer.isHidden = true
//                self.reAskBtn.isHidden = true
//                self.codeTF.isEnabled = false
//                print("same code, Signin complete")
//                self.sendPhoneNumber?.userPhoneNumber(PhoneNumber: self.phoneTF.text!)
//                self.bottomBtn.addTarget(self, action: #selector(self.moveView), for: .touchUpInside)
//            }
//        }
    }
    
    func firebaseLogin(_ credential: AuthCredential) {
//        if let user = Auth.auth().currentUser {
//            user.linkAndRetrieveData(with: credential) { (authResult, error) in
//                if let error = error {
//                    print(error)
//                    return
//                }
//            }
//        } else {
//            Auth.auth().signInAndRetrieveData(with: credential) { (authResult, error) in
//                if let error = error {
//                    print(error)
//                    return
//                }
//            }
//        }
    }
    
    @objc func moveView(){
        let dvc = storyboard?.instantiateViewController(withIdentifier: "signupWriteStoryboard") as! JoinPersonalInfoVC
        present(dvc, animated: true)
    }
}
