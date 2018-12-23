//
//  calenderVC.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 23..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit
import JTAppleCalendar

/** calendar View 다루는 곳 */
class CalendarVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("---- CalendarVC running! ----")
    }
    
}

extension CalendarVC:JTAppleCalendarViewDelegate,JTAppleCalendarViewDataSource{
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
       let myCalendarCell = cell as! CalendarCell
        sharedFunctionToConfigureCell(myCalendarCell: myCalendarCell, cellState: cellState, date: date)
        print("calendar cell setting complete!")
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from : "2019 01 01")!
        let endDate = formatter.date(from : "2019 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let myCalendarCell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarcell", for: indexPath) as! CalendarCell
        myCalendarCell.dateLabel.text! = cellState.text
        
        return myCalendarCell
    }
   
    func sharedFunctionToConfigureCell(myCalendarCell:CalendarCell, cellState: CellState, date: Date){
        myCalendarCell.dateLabel.text! = cellState.text
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        guard let validCell = cell as? CalendarCell else {return}
        validCell.selectedView.isHidden = false
    }
}

