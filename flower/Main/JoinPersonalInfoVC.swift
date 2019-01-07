//
//  JoinPersonalInfoVC.swift
//  flower
//
//  Created by 김지민 on 30/12/2018.
//  Copyright © 2018 성다연. All rights reserved.
//

import UIKit
import PasswordTextField
import BetterSegmentedControl

class JoinPersonalInfoVC: UIViewController {
    var selectSexTypeResult = 0 // 성별 구별
    var uPhoneNumber = ""
    var selectBirthDay = ""
 
    @IBOutlet weak var sexType_1: UIButton!
    @IBOutlet weak var sexType_0: UIButton!
    @IBOutlet weak var finishWritingBtn: UIButton!
    //닉네임
    @IBOutlet var nickNameTF: UITextField!
    @IBOutlet var nickNameWarn: UILabel!
    @IBOutlet var nickNameCheck: UIImageView!
    @IBAction func nickNameEdit(_ sender: Any) {
        //경고창
        if nickNameTF.text?.isEmpty ?? true {
            nickNameWarn.isHidden = false
            nickNameCheck.isHidden = true
        } else {
            nickNameWarn.isHidden = true
            nickNameCheck.isHidden = false
        }
    }
    @IBOutlet var dateTF: UITextField!
    
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
        return picker
    }()
    
    @objc func datePickerChanged(sender:UIDatePicker) {
        let birthFormatter = DateFormatter()
        birthFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        selectBirthDay = birthFormatter.string(from: sender.date)
        dateTF.text = dateFormatter.string(from: sender.date)
    }
    
    lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "   yyyy  년         MM   월         dd   일"
        return formatter
    }()
    
    //ID
    @IBOutlet var idTF: UITextField!
    @IBOutlet var idWarn: UILabel!
    @IBOutlet var idCheck: UIImageView!
    @IBAction func idEdit(_ sender: Any) {
        checkID()
        // 경고창
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
        
        if pwTF.text?.isEmpty ?? true{
            pwWarn.text = "*PW 항목은 필수입력입니다."
            pwWarn.isHidden = false
            pwCheck.isHidden = true
        } else {
//            if pwTF.isInvalid() {
//                pwWarn.text = "*PW는 한글/영문+숫자 조합의 최소 6글자입니다."
//                pwWarn.isHidden = false
//                pwCheck.isHidden = true
//            } else {
//                pwWarn.isHidden = true
//                pwCheck.isHidden = false
//            }
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
    
    // 성별 확인
    @IBOutlet weak var sexType0: UIButton!
    @IBOutlet weak var sexType1: UIButton!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        finishWritingBtn.backgroundColor = UIColor.gray
        nickNameWarn.isHidden = true
        nickNameCheck.isHidden = true
        
        dateTF.inputView = datePicker
        
        idWarn.isHidden = true
        idCheck.isHidden = true
        //PW
        pwWarn.isHidden = true
        pwCheck.isHidden = true
        //PW 확인
        pwSameWarn.isHidden = false
        pwSameCheck.isHidden = true
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setSexType()
        finishWritingBtn.addTarget(self, action: #selector(checkData), for: .touchUpInside)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        datePicker.endEditing(true)
    }
    
    func checkID(){
        idTF.addTarget(self, action: #selector(isSameId), for: .editingDidEnd)
    }
    
    @objc func isSameId(){
        guard let id = idTF.text else {return}
        
        SignService.shared.signUpId(id: id){
            (data) in guard let response = data.status else {return}
            switch response {
            case 200:
                self.idCheck.isHidden = false
                print("success! 사용할 수 있는 아이디입니다.")
            case 204:
                print("아이디 중복 에러")
            case 500:
                print("서버 내부 에러")
            case 600:
                print("데이터베이스 에러")
            default:
                print("중복 ID 체크")
            }
        }
    }
    
    func setNewUserData(){
        guard let nickname = nickNameTF.text else {return}
        guard let id = idTF.text else {return}
        guard let pw = pwTF.text else {return}
        guard let birth = dateTF.text else {return}
        let sexType = selectSexTypeResult
        let testPhoneNumber = "01087188705"
        
        SignService.shared.signUp(name: nickname, id: id, password: pw, phone: testPhoneNumber, birthday: selectBirthDay, sextype: sexType){
            (data) in
            guard let status = data.status else {return}
            switch status {
            case 201:
                print("회원가입 성공")
                self.finishWritingBtn.isEnabled = false
                //UserDefaults.standard.set(token, forKey: "token")
                // 생성 , 참여 창으로
                let dvc = self.storyboard?.instantiateViewController(withIdentifier: "JoinOrCreateStoryBoard") as! JoinCreateEnterVC
                self.present(dvc, animated: true, completion: nil)
            case 400:
                print("아이디 중복")
            case 500:
                print("서버 내부 에러")
            case 600:
                print("데이터베이스 에러")
            default:
                print("Sign to Server")
            }
            print("name = \(nickname)")
            print("id = \(id)")
            print("password = \(pw)")
            print("phone = \(self.uPhoneNumber)")
            print("birthday = \(self.selectBirthDay)")
            print("sexType = \(sexType)")
        }
    }
    
    @objc func checkData(){
        if (!(idTF.text == "" || pwTF.text == "" || nickNameTF.text == "")){
            finishWritingBtn.backgroundColor = UIColor.init(hex: "#366ce2")
            setNewUserData()
        }
        else {
            print("data not set")
        }
    }
    
    func setSexType(){
        sexType_0.addTarget(self, action: #selector(changeSexTypeTo0), for: .touchUpInside)
        sexType_1.addTarget(self, action: #selector(changeSexTypeTo1), for: .touchUpInside)
    }
    
    @objc func changeSexTypeTo0(){
        selectSexTypeResult = 0
        sexType_0.setTitleColor(UIColor.init(hex: "#366ce2"), for: .normal)
        sexType_0.borderColor = UIColor.init(hex: "#366ce2")
        
        sexType_1.setTitleColor(UIColor.init(hex: "#707070"), for: .normal)
        sexType_1.borderColor = UIColor.init(hex: "#707070")
    }
    @objc func changeSexTypeTo1(){
        selectSexTypeResult = 1
        sexType_1.setTitleColor(UIColor.init(hex: "#366ce2"), for: .normal)
        sexType_1.borderColor = UIColor.init(hex: "#366ce2")
        
        sexType_0.setTitleColor(UIColor.init(hex: "#707070"), for: .normal)
        sexType_0.borderColor = UIColor.init(hex: "#707070")
    }
}

extension JoinPersonalInfoVC : SignUpPhoneNumber {
    func userPhoneNumber(PhoneNumber: String) {
        self.uPhoneNumber = PhoneNumber
    }
}
