//
//  JoinEnterVC.swift
//  flower
//
//  Created by 김지민 on 01/01/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import UIKit

class JoinEnterVC: UIViewController,UITextFieldDelegate {


    @IBOutlet var codeTF: UITextField!
    @IBOutlet var sendCodeBtn: UIButton!
    @IBOutlet var warningLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        codeTF.resignFirstResponder()
        warningLabel.isHidden = true
        codeTF.addTarget(self, action: #selector(checkTF), for: UIControl.Event.editingChanged)
    }
    
    @objc func checkTF(){
        if (codeTF.text != ""){
            sendCodeBtn.isEnabled = true
            self.sendCodeBtn.backgroundColor = UIColor.init(hex: "#366ce2")
            sendCodeBtn.addTarget(self, action: #selector(joinGroup), for: .touchUpInside)
        } else {
            sendCodeBtn.isEnabled = false
            self.sendCodeBtn.backgroundColor = UIColor.init(hex: "#808080")
        }
    }
    
    @objc func joinGroup(){
        guard let code = codeTF.text else {return}
        
         GroupService.shared.joinGroup(code: code){
            jimin in guard let jimin2 = jimin.status else {return}
            print(jimin.status)
            
            switch jimin2 {
            case 200:
                print("그룹 참여 성공")
                self.moveToTaps()
            case 201:
                print("이미 가입된 그룹이 있습니다")
            case 400:
                print("그룹 참여 실패")
                self.warningLabel.isHidden = false
            case 401:
                print("초대코드가 유효하지 않습니다")
                self.warningLabel.isHidden = false
            case 500:
                print("서버 내부 에러")
            case 600:
                print("데이터베이스 에러")
            default:
                print("그룹 참여")
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        sendCodeBtn.isEnabled = false
       
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }

    
    func moveToTaps(){
        
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "tabbar")
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
    }
    

}
