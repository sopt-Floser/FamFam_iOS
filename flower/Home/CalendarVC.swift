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
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year : UILabel!
    @IBOutlet weak var month: UILabel!
    let formatter = DateFormatter()
    
    let outsideMonthColor = UIColor(colorWithHexValue: 0xbbbbbb)
    let monthColor = UIColor.black
    let selectedMonthColor = UIColor.white//UIColor(colorWithHexValue: 0x3a294b)
    let currentDateSelectedViewColor = UIColor(colorWithHexValue: 0x4e3f5d)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("---- CalendarVC running! ----")
        
        setupCalendarView()
    }
    
    func setupCalendarView(){
        // setup calendar spacing
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        
        // setup calendar labels
        calendarView.visibleDates{ visibleDates in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    /** 달력 일 색갈 변환기 */
    func handleCellTextColor(view : JTAppleCell?, cellState: CellState){
        guard let littleCalendarCell = view as? CalendarCell else {return}
        
        if cellState.isSelected {
            littleCalendarCell.dateLabel.textColor! = selectedMonthColor
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                littleCalendarCell.dateLabel.textColor! = monthColor
            } else {
                littleCalendarCell.dateLabel.textColor! = outsideMonthColor
            }
        }
    }
    
    func handleCellSelected(view : JTAppleCell?, cellState: CellState){
        guard let validCell = view as? CalendarCell else {return}
        if cellState.isSelected {
            validCell.selectedView.isHidden = false
        } else {
            validCell.selectedView.isHidden = true
        }
    }
    
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo){
        let date = visibleDates.monthDates.first!.date
        
        self.formatter.dateFormat = "yyyy"
        self.year.text = self.formatter.string(from: date)
        
        self.formatter.dateFormat = "MMMM"
        self.month.text = self.formatter.string(from: date)
    }
    

}

extension CalendarVC:JTAppleCalendarViewDataSource{
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
       let myCalendarCell = cell as! CalendarCell
        sharedFunctionToConfigureCell(myCalendarCell: myCalendarCell, cellState: cellState, date: date)
        print("calendar cell setting complete!")
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from : "2018 12 02")!
        let endDate = formatter.date(from : "2019 12 02")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
   
    func sharedFunctionToConfigureCell(myCalendarCell:CalendarCell, cellState: CellState, date: Date){
        myCalendarCell.dateLabel.text! = cellState.text
    }
}

extension CalendarVC:JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let myCalendarCell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarcell", for: indexPath) as! CalendarCell
        
        myCalendarCell.dateLabel.text! = cellState.text
        handleCellSelected(view: myCalendarCell, cellState: cellState)
        handleCellTextColor(view: myCalendarCell, cellState: cellState)
        
        return myCalendarCell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleCellSelected(view: cell, cellState: cellState)
        handleCellTextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar:JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo){
        let date = visibleDates.monthDates.first!.date
        
        formatter.dateFormat = "yyyy"
        year.text = formatter.string(from: date)
        
        formatter.dateFormat = "MMMM"
        month.text = formatter.string(from: date)
    }
}

extension UIColor{
    convenience init(colorWithHexValue value: Int, alpha:CGFloat = 1.0){
        self.init(
            red: CGFloat((value & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((value & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(value & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
