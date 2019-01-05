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
    
    var delegate: PopupPickerSelectDelegate?
    var selectedDate = Date()
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBAction func selectDateBtn(_ sender: Any) {
        formatDate = selectDateFormatter()
        print("selected date \(selectedDate)")
        self.delegate?.selectPicker(date: selectedDate)
        dismiss(animated: true, completion: nil)
        print("formatDate = \(formatDate)")
        
    }
    @IBAction func dismissPopup(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }

    @objc func dateChanged() {
        selectedDate = datePicker.date
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
        datePicker.addTarget(self, action: #selector(dateChanged), for: .valueChanged)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
    }
}
