//
//  JoinPersonalInfoVC.swift
//  flower
//
//  Created by 김지민 on 30/12/2018.
//  Copyright © 2018 성다연. All rights reserved.
//

import UIKit
import PasswordTextField

class JoinPersonalInfoVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //닉네임
        nickNameWarn.isHidden = true
        nickNameCheck.isHidden = true
        
        //성별
        //생년월일
        dateTF.inputView = datePicker
        //        female?.buttonArray = [male!]
        //        male?.buttonArray = [female!]
        //ID
        idWarn.isHidden = true
        idCheck.isHidden = true
        //PW
        pwWarn.isHidden = true
        pwCheck.isHidden = true
        //PW 확인
        pwSameWarn.isHidden = false
        pwSameCheck.isHidden = true
    }
    
    
//닉네임
    @IBOutlet var nickNameTF: UITextField!
    @IBOutlet var nickNameWarn: UILabel!
    @IBOutlet var nickNameCheck: UIImageView!
    @IBAction func nickNameEdit(_ sender: Any) {
        
        if nickNameTF.text?.isEmpty ?? true {
            nickNameWarn.isHidden = false
            nickNameCheck.isHidden = true
        } else {
            nickNameWarn.isHidden = true
            nickNameCheck.isHidden = false
        }
    }
    
//성별 선택 못하겠어요

//    @IBOutlet var female: genderSelection!
//    @IBOutlet var male: genderSelection!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        female.isSelected = true
//        male.isSelected = false
//    }
//

    
    
//생년월일
//    var placeholder = NSAttributedString(string: "               년               월                 일", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
    
    @IBOutlet var dateTF: UITextField!
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
//        dateTF.attributedPlaceholder = placeholder;
        return picker
    }()
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "   yyyy  년         MM   월         dd   일"
        return formatter
    }()
    
    @objc func datePickerChanged(sender:UIDatePicker) {
        dateTF.text = dateFormatter.string(from: sender.date)

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    //ID
    
    @IBOutlet var idTF: UITextField!
    @IBOutlet var idWarn: UILabel!
    @IBOutlet var idCheck: UIImageView!
    @IBAction func idEdit(_ sender: Any) {
       
        if idTF.text?.isEmpty ?? true {
            idWarn.isHidden = false
        } else {
            idWarn.isHidden = true
        }
        
    }
    //ID 서버와의 중복체크 기능

    //PW
    @IBOutlet var pwTF: PasswordTextField!
    @IBOutlet var pwWarn: UILabel!
    @IBOutlet var pwCheck: UIImageView!
    @IBAction func pwEdit(_ sender: Any) {
        
        
        //regex 뒤쪽 수정하면 비번 규칙 수정 가능
        let validationRule = RegexRule(regex:"^(?=.*?[0-9]).{6,}$")
        pwTF.validationRule = validationRule
        
        if pwTF.text?.isEmpty ?? true{
            pwWarn.text = "*PW 항목은 필수입력입니다."
            pwWarn.isHidden = false
            pwCheck.isHidden = true
        } else {
            if pwTF.isInvalid() {
                pwWarn.text = "*PW는 한글/영문+숫자 조합의 최소 6글자입니다."
                pwWarn.isHidden = false
                pwCheck.isHidden = true
            } else {
                pwWarn.isHidden = true
                pwCheck.isHidden = false
            }
            
        }
        //패스워드 입력 유무, 조건 충족 유무
        //지금은 6글자 이상의 숫자포함 비번으로 임시설정
    }
    
    //PW확인
    @IBOutlet var pwSameTF: PasswordTextField!
    @IBOutlet var pwSameWarn: UILabel!
    @IBOutlet var pwSameCheck: UIImageView!
    @IBAction func pwSameEdit(_ sender: Any) {
       
        if pwSameTF.text == pwTF.text {
            pwSameWarn.isHidden = true
            pwSameCheck.isHidden = false
        } else {
            pwSameWarn.isHidden = false
            pwSameCheck.isHidden = true
    
        }
    }
    
    //가입완료 창 활성화 하려면 모든 경고창 isHidden 이 true, 모든 체크 이미지 isHidden이 false 일때 가입완료 창이 파란색이 되면서 활성화 됨
    
    //
    
//    @IBOutlet var joinCompleteBtn: UIButton!
//    @IBAction func joinComplete(_ sender: Any) {
//    
//        if(pwSameCheck.isHidden == true) {
//            joinCompleteBtn.layer.backgroundColor = UIColor(red: 54, green: 108, blue: 226, alpha: 1.0).cgColor
//            self.performSegue(withIdentifier: "CreateEnter", sender: self)
//        } else {
//            joinCompleteBtn.layer.backgroundColor = UIColor(red: 54, green: 108, blue: 226, alpha: 1.0).cgColor
//        }
//    }
    
}

