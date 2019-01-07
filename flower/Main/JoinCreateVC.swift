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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        GroupService.shared.inviteGroup{ jimin in
            guard let jimin2 = jimin.status else {return}
            guard let jimin3 = jimin.data else {return}
            switch jimin2{
            case 200 :
                self.codeLabel.text = jimin3.code!
                print ("아무말")
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

    override func viewDidLoad() {
        super.viewDidLoad()
        

    }


}
