//
//  PlusVC.swift
//  flower
//
//  Created by 김지민 on 02/01/2019.
//  Copyright © 2019 성다연. All rights reserved.
//

import UIKit


var myPlusInfoArray: [PlusData] = []

class PlusVC: UIViewController {
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPlusData() // 정보 받아오는 함수
        setPlusData() // 정보를 화면에 넣는 함수
    }
    
    
    ///// 배경화면 aspect fill 같은 거 차후 수정
    @IBOutlet var plusBackPic: UIImageView! // 내 배경화면
    @IBOutlet var plusCR: UILabel! // 디자인용 레이블
    
    func DesignPlusCR(){ // 디자인용 레이블 설정
        let path = UIBezierPath(roundedRect:plusCR.bounds,
                                byRoundingCorners:[.topRight, .topLeft],
                                cornerRadii: CGSize(width: 12, height:  12))
        let maskLayer = CAShapeLayer()
        maskLayer.path = path.cgPath
        plusCR.layer.mask = maskLayer
    }
    
    @IBOutlet var profilePic: UIImageView! // 내 프사
    
    func MakeProfilePicRound(){ //프사 둥글게 하는 함수
        profilePic.layer.masksToBounds = false
        profilePic.layer.cornerRadius = profilePic.frame.height/2
        profilePic.clipsToBounds = true
    }
    //프사 이미지 넣기
    
    @IBOutlet var myName: UILabel! // 내 이름
    @IBOutlet var myIntroduce: UILabel! // 소갯말
    @IBOutlet var myVersionInfo: UILabel! // 버전 저오
    
    
    func setPlusData(){
        
        
        func stringOptionalUnwork(_ value: String?) -> String{
            guard let value_ = value else {
                return ""
            }
            return value_
        }
        
        let myPlus = myPlusInfoArray[0]
        
        var checkimage = myPlus.plusBackPic
        self.plusBackPic?.image = UIImage(named:stringOptionalUnwork(checkimage))
        
        DesignPlusCR()
        
        checkimage = myPlus.profilePic
        self.profilePic?.image = UIImage(named:stringOptionalUnwork(checkimage))
        
        MakeProfilePicRound()

        self.myName.text = myPlus.myName
        self.myIntroduce.text = myPlus.myIntroduce
        self.myVersionInfo.text = myPlus.myVersionInfo
        
    }
}

extension PlusVC {
    func getPlusData() {
        let myPlusData = PlusData(backPic: "family", profilePic: "sampleProfile", name: "이승수", introduce: "아요 파트장입니다 ^^*", version: "1.2.3")
        myPlusInfoArray = [myPlusData]
        
    }
}

