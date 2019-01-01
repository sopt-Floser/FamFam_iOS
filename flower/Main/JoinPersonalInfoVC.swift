//
//  JoinPersonalInfoVC.swift
//  flower
//
//  Created by 김지민 on 30/12/2018.
//  Copyright © 2018 성다연. All rights reserved.
//

import UIKit

class JoinPersonalInfoVC: UIViewController {

    
    
    
//성별 선택
    

    
    
    
    
//생년월일
    var placeholder = NSAttributedString(string: "               년               월                 일", attributes: [NSAttributedString.Key.foregroundColor : UIColor.darkGray])
    @IBOutlet var dateTF: UITextField!
   
    lazy var datePicker: UIDatePicker = {
        let picker = UIDatePicker()
        picker.datePickerMode = .date
        picker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
        dateTF.attributedPlaceholder = placeholder;
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
    
}
