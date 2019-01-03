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

    @IBAction func loginAction(_ sender: Any) {
        guard let id = idTF.text else {return}
        guard let password = passwordTF.text else {return}
        
        
        if(!(id == "" && password == "")) {
            LoginService.shared.login(id: id, password: password){
                (data) in print(data.token)
            }
            moveToTaps()
        }
        else if (id == "admin" && password == "admin") {
            moveToTaps()
        }
        else {
            print("id, password 입력해주세용")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func moveToTaps(){
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "tabbar")
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
    }

}
