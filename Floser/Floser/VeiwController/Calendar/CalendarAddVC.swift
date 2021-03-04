//
//  CalendarAddViewViewController.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 26..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit
import BetterSegmentedControl

class CalendarAddVC: UIViewController, UITextFieldDelegate {
    @IBAction func cancleBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
   
    // personView outlet
    @IBOutlet weak var perseonView: UIView!
    @IBOutlet weak var personTitleTF: UITextField!
    @IBOutlet weak var personDateLabel: UILabel!
    
    // familyView outlet
    @IBOutlet weak var familyView: UIView!
    @IBOutlet weak var familyTitleTF: UITextField!
    @IBOutlet weak var familyDateLabel: UILabel!
    @IBOutlet weak var familyAlarmOutlet: UISwitch!
    @IBAction func familyAlarm(_ sender: Any) {
        //알람 설정 없음
    }
    
    @IBOutlet weak var saveBtnOutlet: UIButton!
    @IBAction func saveBtn(_ sender: Any) {
        // 데이터 추가 코드
    self.presentingViewController?.presentingViewController?.dismiss(animated: false, completion: nil)
    }
    
    
    /** 세그먼트 폰트, 색상 설정 */
    let segmentColor = UIColor(red: 0.26, green: 0.43, blue: 0.85, alpha: 1.0)
    let segmentFont = "DiwanMishafi"
    var buttonBar = UIView()
    var switchSegment = UISegmentedControl()
    var newAddDate : CalendarModel = CalendarModel.init(date: "", memo: "", color: "#366CE2")

    private var delegate : CalendarListPopupVCDelegate?
    
    /** 일정 추가 세그먼트 */
    var familyBsegmentSeletedNum = 0
    var personEatBsegmentSelectedNum = 0
    var personBackBsegmentSelectedNum = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        segmentSetting()
        setFamilyView()
        setPersonView()
    }

    override func viewWillDisappear(_ animated: Bool) {
        switchSegment = UISegmentedControl()
        buttonBar = UIView()
    }
}

extension CalendarAddVC {
    func segmentSetting(){
        switchSegment.insertSegment(withTitle: "개인 일정", at: 0, animated: true)
        switchSegment.insertSegment(withTitle: "가족 일정", at: 1, animated: true)
        switchSegment.selectedSegmentIndex = 0
        switchSegment.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(switchSegment)
        
        switchSegment.topAnchor.constraint(equalTo: view.topAnchor, constant: 70).isActive = true

        switchSegment.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        switchSegment.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        switchSegment.backgroundColor = .clear
        switchSegment.tintColor = .clear
        switchSegment.setTitleTextAttributes([
            NSAttributedString.Key.font : UIFont(name: segmentFont, size: 18)!,
            NSAttributedString.Key.foregroundColor: UIColor.lightGray
            ], for: .normal)
        switchSegment.setTitleTextAttributes([NSAttributedString.Key.font: UIFont(name: segmentFont,size : 18)!,
            NSAttributedString.Key.foregroundColor: segmentColor],  for: .selected)
        
        switchSegment.addTarget(self, action: #selector(CalendarAddVC.segmentControlValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        buttonbarSetting()
    }
    
    @objc func segmentControlValueChanged(_ sender: UISegmentedControl){
        UIView.animate(withDuration: 0.3){
            self.buttonBar.frame.origin.x = (self.switchSegment.frame.width / CGFloat(self.switchSegment.numberOfSegments)) * CGFloat(self.switchSegment.selectedSegmentIndex)
        }
        if switchSegment.selectedSegmentIndex == 0 {
            UIView.animate(withDuration: 0.3, animations: { 
                self.perseonView.isHidden = true
                self.familyView.isHidden = false
            })
        } else {
            UIView.animate(withDuration: 0.3, animations: {
                self.perseonView.isHidden = false
                self.familyView.isHidden = true
            })
        }
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
        textField.resignFirstResponder()
        return true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        familycheckData()
        personCheckData()
        self.view.endEditing(true)
    }
    @objc func keyboardWillShow(_ sender: Notification){
        self.view.frame.origin.y = -150
    }
    @objc func keyboardWillHide(_ sender: Notification){
        self.view.frame.origin.y = 0
    }
}

extension CalendarAddVC {
    func image(with image: UIImage?, scaledTo newSize: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(newSize)
        image?.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
    }
    
    func setPersonView(){
        personDateLabel.text = setDateLabel()
        
        let eatSegmentControl = BetterSegmentedControl(frame: CGRect(x: (view.frame.width - 302 ) / 2 - 4, y: (view.frame.height)/2 - 100, width: 306, height: 38), segments: LabelSegment.segments(withTitles: ["같이 먹어요!", "먹고 올게요!"], normalBackgroundColor: .white, normalTextColor: UIColor.init(hex: "#656565"), selectedBackgroundColor: .white, selectedTextColor: UIColor.init(hex: "#366CE2")), index: 1, options: [.backgroundColor(UIColor.init(hex: "#656565")), .indicatorViewBackgroundColor(UIColor.init(hex: "#366CE2")) ])
        
        let backSegmentControl = BetterSegmentedControl(frame: CGRect(x: (view.frame.width - 302) / 2 - 4, y: (view.frame.height) / 2 + 14, width: 306, height: 75), segments: LabelSegment.segments(withTitles: ["10시 전", "10시 ~ 12시", "12시 이후"], normalBackgroundColor: .white, normalTextColor: UIColor.init(hex: "#656565"), selectedBackgroundColor: .white, selectedTextColor: UIColor.init(hex: "#366CE2")), index: 1, options: [.backgroundColor(UIColor.init(hex: "#656565")), .indicatorViewBackgroundColor(UIColor.init(hex: "#366CE2")) ])
        
        eatSegmentControl.layer.cornerRadius = 5
        backSegmentControl.layer.cornerRadius = 5
        
        eatSegmentControl.addTarget(self, action: #selector(CalendarAddVC.personEatSegmentControl(_:)), for: .valueChanged)
        backSegmentControl.addTarget(self, action: #selector(CalendarAddVC.personBackSegmentControl(_:)), for: .valueChanged)

        perseonView.addSubview(eatSegmentControl)
        perseonView.addSubview(backSegmentControl)
    }

    func setFamilyView(){
        let selectAnniversary = BetterSegmentedControl(
            frame: CGRect(x: (view.frame.width - 303) / 2 - 3, y: 73, width: 314, height: 83),
            segments: LabelSegment.segments(withTitles: ["", ""], normalFont: UIFont(name: "HelveticaNeue-Light", size: 14.0)!, normalTextColor: .lightGray, selectedFont: UIFont(name: "HelveticaNeue-Bold", size: 14.0)!, selectedTextColor: .white),
            index: 1, options: [.backgroundColor(UIColor.init(hex: "#E4E4E4")),
                                .indicatorViewBackgroundColor(UIColor.init(hex: "#366CE2"))])
        selectAnniversary.layer.cornerRadius = 5
        
        selectAnniversary.addTarget(self, action: #selector(CalendarAddVC.familycontrolValueChanged(_:)), for: .valueChanged)
        
        selectAnniversary.announcesValueImmediately = true
        familyView.addSubview(selectAnniversary)
        
        let cakeImage = image(with: UIImage(named: "btn_birthday"), scaledTo: CGSize(width: 148, height: 73))
        let cakeImageView = UIImageView(image: cakeImage)
        cakeImageView.frame = CGRect(x: (view.frame.width - 302) / 2 + 2, y: 78, width: 148, height: 73)
        
        let firecrackerImage = image(with: UIImage(named: "btn_another_anniversary"), scaledTo: CGSize(width: 148, height: 73))
        let firecrackerImageView = UIImageView(image: firecrackerImage)
        firecrackerImageView.frame = CGRect(x: (view.frame.width - 302) / 2 + 157, y: 78, width: 148, height: 73)
        

        familyView.addSubview(cakeImageView)
        familyView.addSubview(firecrackerImageView)
        familyDateLabel.text = setDateLabel()
        setSwitchBtn()
        
    }
    
    func setSwitchBtn(){
        familyAlarmOutlet.onTintColor = UIColor.init(hex: "#366CE2")
    }
    
    //날짜 ~~년 ~~월 ~~일 변환
    func setDateLabel() -> String{
        if let dele = delegate {
            return dele.selectDate.returnStringValue(format:  "yyyy년 MM월 dd일")
        }
        return "yyyy년 MM월 dd일"
    }
    
    // 가족 일정 데이터 입력 확인
    func familycheckData() {
        if familyTitleTF.text?.isEmpty == false {
            saveBtnOutlet.isUserInteractionEnabled = true
            saveBtnOutlet.backgroundColor = UIColor.init(hex: "#366CE2")
        } else {
            saveBtnOutlet.isUserInteractionEnabled = false
            saveBtnOutlet.backgroundColor = UIColor.init(hex: "9B9B9B")
        }
    }
    
    // 개인 일정 데이터 입력 확인
    func personCheckData(){
        if personTitleTF.text?.isEmpty == false {
            saveBtnOutlet.backgroundColor = UIColor.init(hex: "#366CE2")
            perseonView.reloadInputViews()
        } else {
            saveBtnOutlet.isUserInteractionEnabled = false
            saveBtnOutlet.backgroundColor = UIColor.init(hex: "9B9B9B")
        }
    }
    
    @objc func familycontrolValueChanged(_ sender: BetterSegmentedControl){
        familyBsegmentSeletedNum = Int(sender.index)
        personCheckData()
    }
    @objc func personEatSegmentControl(_ sender: BetterSegmentedControl){
        personEatBsegmentSelectedNum = Int(sender.index)
        familycheckData()
    }
    @objc func personBackSegmentControl(_ sender: BetterSegmentedControl){
        personBackBsegmentSelectedNum = Int(sender.index)
        familycheckData()
    }
}
