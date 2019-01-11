//
//  weekCalendarCell.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 28..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit

class missionCell: UICollectionViewCell {
    @IBOutlet weak var missionView: UIView!
    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var missionPerson: UILabel!
    @IBOutlet weak var missionLabel: UILabel!
    @IBOutlet weak var missionImage: UIImageView!
    
    
    override func awakeFromNib() {
        MissionService.shared.getMission(){ data in
            guard let status = data.status else {return}
            guard let content = data.data?.mission?.content else {return}
            guard let missionType = data.data?.mission?.missionType else {return}
            guard let target = data.data?.target else {return}
            
            switch status {
            case 200 :
                self.missionView.isHidden = false
                self.missionPerson.text = target
                self.missionLabel.text = content
                self.changeImage(num: missionType)
                print("미션 조회 성공")
            case 204 :
                print("구성원을 찾아보세요")
            case 404 :
                print("회원을 찾을 수 없습니다")
            case 500:
                print("서버 내부 에러")
            case 600:
                print("데이터베이스 에러")
            default:
                print("미션 조회 시도중")
            }
        }
    }
    
    
    // mission type 에 따른 이미지 분류
    func changeImage(num:Int){
        if num <= 3 {
            if num == 1 {
                
            }
            else if num == 2 {
                
            }
            else {
                
            }
        }
        else if num <= 6{
            if num == 4 {
                
            }
            else if num == 5 {
                
            } else {
                
            }
        } else if num == 7{
            
        }
    }
    
    /** 효과 씌우기 */
    override func layoutSubviews() {
        super.layoutSubviews()

        self.layer.cornerRadius = 15
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 10)
        self.clipsToBounds = false
    
    }
}
