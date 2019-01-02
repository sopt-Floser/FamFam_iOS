//
//  CalendarListPopupVC.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 31..
//  Copyright © 2018년 성다연. All rights reserved.
//
import Foundation
import UIKit

var switchDate = Date()
var formatDate = ""

class CalendarListPopupVC: UIViewController {
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func selectDateBtn(_ sender: Any) {
        
        datePicker.addTarget(self, action: #selector(dateChanged(datePicker:)), for: .valueChanged)
        switchDate = datePicker.date 
        formatDate = selectDateFormatter()
        dismiss(animated: true, completion: nil)
        print("formatDate = \(formatDate)")
        
    }
    @IBAction func dismissPopup(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @objc func dateChanged(datePicker: UIDatePicker){
        print("this function doesn't work")
    }
    
    func selectDateFormatter() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy MM dd"
        let returnValue = formatter.string(from: datePicker?.date ?? Date())
        print("picker date = \(returnValue)")
        return returnValue
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
}
