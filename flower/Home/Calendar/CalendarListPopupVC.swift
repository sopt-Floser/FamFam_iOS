//
//  CalendarListPopupVC.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 31..
//  Copyright © 2018년 성다연. All rights reserved.
//
import Foundation
import UIKit

var switchDate:Date = Date()

class CalendarListPopupVC: UIViewController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func selectDateBtn(_ sender: Any) {
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        switchDate = datePicker.date
        dismiss(animated: true, completion: nil)
    }
    @IBAction func dismissPopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @objc func dateChanged(datePicker: UIDatePicker){
        print("this function doesn't work")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
}
