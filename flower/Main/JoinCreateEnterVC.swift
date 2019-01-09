//
//  JoinCreateEnterVC.swift
//  flower
//
//  Created by 김지민 on 01/01/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import UIKit

class JoinCreateEnterVC: UIViewController {

    @IBOutlet weak var createBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createBtn.addTarget(self, action: #selector(createGroupSelector), for: .touchUpInside)

        // Do any additional setup after loading the view.
    }
    

    @objc func createGroupSelector(){
        createGroup()
    }
    
    func createGroup(){
        GroupService.shared.createGroup{ res in
            switch res.status {
            case 201 :
                print("그룹 생성 성공~")
                self.moveViews()
            case 204:
                print("이미 가입된 그룹이 있습니다.")
            case 400 :
                print("회원을 찾을 수 없습니다")
            case 500:
                print("사버 내부 에러")
            case 600 :
                print("DB 에러")
            default:
                print("그룹 생성 시도 중")
            }
        }
    }
    
    func moveViews(){
        let appDelegate = UIApplication.shared.delegate! as! AppDelegate
        let initialViewController = self.storyboard!.instantiateViewController(withIdentifier: "tabbar")
        appDelegate.window?.rootViewController = initialViewController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    
    

}
