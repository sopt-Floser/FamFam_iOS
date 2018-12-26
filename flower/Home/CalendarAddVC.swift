//
//  CalendarAddViewViewController.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 26..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit

class CalendarAddVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var switchSegment: UISegmentedControl!
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
    }
    
    
    @objc func keyboardWillShow(_ sender: Notification){
        self.view.frame.origin.y = -150
    }
    @objc func keyboardWillHide(_ sender: Notification){
        self.view.frame.origin.y = 0
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        titleTextField.delegate = self
       
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}
