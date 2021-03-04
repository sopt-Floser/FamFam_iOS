//
//  CalendarListPopupVC.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 31..
//  Copyright © 2018년 성다연. All rights reserved.
//
import Foundation
import UIKit

protocol CalendarListPopupVCDelegate {
    var selectDate : Date { get set }
}

class CalendarListPopupVC: UIViewController, CalendarListPopupVCDelegate {
    var delegate: PopupPickerSelectDelegate?
    var selectedDate = Date()
    var selectDate: Date {
        get {
            return selectedDate
        }
        set {
            selectedDate = newValue
        }
    }
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func selectDateBtn(_ sender: Any) {
        self.delegate?.selectPicker(date: selectedDate)
        dismiss(animated: true)
    }
    
    @IBAction func dismissPopup(_ sender: Any) {
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }

    @objc func dateChanged() {
        selectedDate = datePicker.date
    }
}
