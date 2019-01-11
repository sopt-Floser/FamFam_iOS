//
//  JoinAgreementVC.swift
//  flower
//
//  Created by 김지민 on 30/12/2018.
//  Copyright © 2018 성다연. All rights reserved.
//

import UIKit


class JoinAgreementVC: UIViewController, sendBtnDataDelegate, sendBtn2DataDelegate {
    @IBOutlet weak var secondBtn: UIButton!
    @IBOutlet weak var thirdBtn: UIButton!
    @IBOutlet weak var fourthBtn: UIButton!
    @IBOutlet weak var fifthBtn: UIButton!
    @IBOutlet weak var sixthBtn: UIButton!
    @IBOutlet weak var completeBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.reloadInputViews()
        setButtons()
    }
    
    func setButtons(){
        fourthBtn.addTarget(self, action: #selector(clearFourthBtn), for: .touchUpInside)
        fifthBtn.addTarget(self, action: #selector(checkFifthBtn), for: .touchUpInside)
        sixthBtn.addTarget(self, action: #selector(checkSixthBtn), for: .touchUpInside)
        
        completeBtn.addTarget(self, action: #selector(completeSelector), for: .touchUpInside)
    }
    
    func sendData(data: Bool) {
        print("data = \(data)")
        changeImage(btn: secondBtn)
    }
    
    func sendData2(data: Bool) {
        changeImage(btn: thirdBtn)
    }
    
    //선택 시 5,6 버튼 전체 클릭, 전체 해제
    @objc func clearFourthBtn() {
        changeImage(btn: fourthBtn)
        setEqual(btn: fourthBtn)
    }
   
    @objc func checkFifthBtn() {
        changeImage(btn: fifthBtn)
    }
    
    @objc func checkSixthBtn(){
        changeImage(btn: sixthBtn)
    }
    
    @objc func completeSelector(){
        if (secondBtn.currentImage!.isEqual(UIImage(named: "btnCheakOn")) && thirdBtn.currentImage!.isEqual(UIImage(named: "btnCheakOn"))){
            let dvc = storyboard?.instantiateViewController(withIdentifier: "joinCellPhoneVC") as! JoinCellPhoneVC
            present(dvc, animated: true)
        }else{
            ToastView.shared.short(self.view, txt_msg: "필수 사항이 완료되지 않았습니다.")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "show1" {
            let viewController : appAgreementVC = segue.destination as! appAgreementVC
            viewController.delegate1 = self
        }
        
        if segue.identifier == "show2" {
            let viewController : userAgreementVC = segue.destination as! userAgreementVC
            viewController.delegate2 = self
        }
    }
    
    func changeImage(btn:UIButton){
        if (btn.currentImage!.isEqual(UIImage(named: "btnCheakOn"))) {
            btn.setImage(UIImage(named: "btnCheakOff"), for: .normal)
        } else {
            btn.setImage(UIImage(named: "btnCheakOn"), for: .normal)
        }
    }
    
    func setEqual(btn:UIButton){
        if (btn.currentImage!.isEqual(UIImage(named: "btnCheakOn"))){
            fifthBtn.setImage(UIImage(named: "btnCheakOn"), for: .normal)
            sixthBtn.setImage(UIImage(named: "btnCheakOn"), for: .normal)
        } else {
            fifthBtn.setImage(UIImage(named: "btnCheakOff"), for: .normal)
            sixthBtn.setImage(UIImage(named: "btnCheakOff"), for: .normal)
        }
    }
    
    
}
