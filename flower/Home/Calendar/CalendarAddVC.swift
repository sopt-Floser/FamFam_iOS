//
//  CalendarAddViewViewController.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 26..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit

var buttonBar = UIView()
var switchSegment = UISegmentedControl()

class Responder: NSObject{
    @objc func segmentControlValueChanged(_ sender: UISegmentedControl){
        UIView.animate(withDuration: 0.3){
            buttonBar.frame.origin.x = (switchSegment.frame.width / CGFloat(switchSegment.numberOfSegments)) * CGFloat(switchSegment.selectedSegmentIndex)
        }
    }
}

let responder = Responder()


/** 할 것
 1. 버튼 여러개 클릭 시 앱 터짐 -> 오류 처리문 작성
 2. 데이터 저장, 서버에 전달하기
 3. 가족일정 (수정)
 */


class CalendarAddVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var dateLabel: UILabel!
    @IBAction func eatBtn_Yes(_ sender: Any) {
    }
    @IBAction func eatBtn_No(_ sender: Any) {
    }
  
    @IBAction func cancleBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func saveBtn(_ sender: Any) {
        // 데이터 추가 코드
        
        //dismiss(animated: false, completion: nil)
        self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
        
    }
    
    /** 세그먼트 폰트, 색상 설정 */
    let segmentColor = UIColor(red: 0.26, green: 0.43, blue: 0.85, alpha: 1.0)
    let segmentFont = "DiwanMishafi"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentSetting()
        titleTextField.delegate = self
    }

    /** 세그먼트, 하단 바 초기화 */
    override func viewWillDisappear(_ animated: Bool) {
        switchSegment = UISegmentedControl()
        buttonBar = UIView()
    }
    
    
    
    /** 세그먼트 바 설정 */
    func segmentSetting(){
        switchSegment.insertSegment(withTitle: "개인 일정", at: 0, animated: true)
        switchSegment.insertSegment(withTitle: "가족 일정", at: 1, animated: true)
        switchSegment.selectedSegmentIndex = 0
        switchSegment.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(switchSegment)
        
        switchSegment.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        //switchSegment.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        switchSegment.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        switchSegment.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        switchSegment.backgroundColor = .clear
        switchSegment.tintColor = .clear
        switchSegment.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: segmentFont, size: 18),
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)
        switchSegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: segmentFont,size : 18),
            NSAttributedString.Key.foregroundColor: segmentColor],  for: .selected)
        
        switchSegment.addTarget(responder, action: #selector(responder.segmentControlValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        buttonbarSetting()
    }
    
    /** 세그먼트 하단 바 설정 */
    func buttonbarSetting(){
        buttonBar.translatesAutoresizingMaskIntoConstraints = false
        buttonBar.backgroundColor = segmentColor
        view.addSubview(buttonBar)
        
        buttonBar.topAnchor.constraint(equalTo: switchSegment.bottomAnchor).isActive = true
        buttonBar.heightAnchor.constraint(equalToConstant: 5).isActive = true
        buttonBar.leftAnchor.constraint(equalTo: switchSegment.leftAnchor).isActive = true
        buttonBar.widthAnchor.constraint(equalTo: switchSegment.widthAnchor, multiplier: 1 / CGFloat(switchSegment.numberOfSegments)).isActive = true
    }
    
    /** 키보드 처리 */
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(_ sender: Notification){
        self.view.frame.origin.y = -150
    }
    @objc func keyboardWillHide(_ sender: Notification){
        self.view.frame.origin.y = 0
    }
    
    func keyboardAccessorySetting(){
    
    }
}

