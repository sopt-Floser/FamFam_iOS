//
//  LogInViewController.swift
//  flower
//
//  Created by 김지민 on 27/12/2018.
//  Copyright © 2018 성다연. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet var idTF: UITextField!
    @IBOutlet var passwordTF: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loginBtn.addTarget(self, action: #selector(login), for: .touchUpInside)
    }
    
    @objc func login(){
        guard let id = idTF.text else {return}
        guard let password = passwordTF.text else {return}
        
        LoginService.shared.login(id: id, password: password){
            (data) in guard let status = data.status else {return}
            print("\n\nstatus = \(status)")
            switch status {
            case 200:
                print("로그인 성공")
                guard let token = data.data?.token else { return }
                UserDefaults.standard.set(token, forKey: "token")
                self.moveToTaps()
            case 400:
                print("로그인 실패")
            case 500 :
                print("로그인 - 서버 내부 에러")
            case 600 :
                print("로그인 - 데이터베이스 에러")
            default:
                print("Login to Server")
                
            }
        }
    }
    
    func moveToTaps(){
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "tabbar")
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
    }

}
