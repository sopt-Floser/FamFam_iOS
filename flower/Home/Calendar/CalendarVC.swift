//
//  calenderVC.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 23..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit
import JTAppleCalendar

typealias DateString = String

/** calendar 다루는 곳 */

class CalendarVC: UIViewController {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year : UILabel!
    @IBOutlet weak var month: UILabel!
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
    let todayDate = Date()
    /** 날,월,일 변환기 */
    let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = "yyyy MM dd"
        return dateFormatter
    }()
    
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer){
        print("long press")
        
        if gesture.state == UIGestureRecognizer.State.began{
        }
    }
    
    var eventsFromTheServer: [String:String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /** 서버 정보 가져오기 */
        DispatchQueue.global().asyncAfter(deadline: .now() /* 양이 많을 시 시간 추가 + 1 */ ){
            let serverObject = self.getServerEvents()
            for (date, event) in serverObject{
                let stringDate = self.formatter.string(from: date)
                self.eventsFromTheServer[stringDate] = event
            }
            DispatchQueue.main.async {
                self.calendarView.reloadData()
            }
        }

        calendarView.visibleDates { dateSegment in
            self.setupCalendarView(dateSegment: dateSegment)
        }
        
        calendarView.addGestureRecognizer(longPressGesture)
        
    }
    
    func setupCalendarView(dateSegment: DateSegmentInfo){
        guard let date = dateSegment.monthDates.first?.date else {return}
        
        formatter.dateFormat = "MMMM"
        month.text = formatter.string(from: date)
        
        formatter.dateFormat = "yyyy"
        year.text = formatter.string(from: date)
        
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
    }
    
    
    func configureCell(cell: JTAppleCell?, cellState: CellState){
        guard let myCalendarCell = cell as? CalendarCell else {return}
        formatter.dateFormat = "yyyy MM dd"
        
        handleCellTextColor(cell: myCalendarCell, cellState: cellState)
        handleCellSelected(cell: myCalendarCell, cellState: cellState)
        handleCellVisibility(cell: myCalendarCell, cellState: cellState)
        handleCellEvent(cell: myCalendarCell, cellState: cellState)
    }
    
    /** 달력 일 색갈 변환기 */
    func handleCellTextColor(cell: CalendarCell, cellState: CellState){
        let todayDateString = formatter.string(from: todayDate)
        let monthDateString = formatter.string(from: cellState.date)
        
        // 오늘 = 오렌지색
        if todayDateString == monthDateString {
            cell.dateLabel.textColor = UIColor.orange
        } else { // 선택한 날
           cell.dateLabel.textColor = cellState.isSelected ? UIColor.white : UIColor.black
        }
    }
    
    func handleCellVisibility(cell:CalendarCell, cellState: CellState){
        cell.isHidden = cellState.dateBelongsTo == .thisMonth ? false : true
    }
    
    /** 날짜 선택 시 이벤트 */
    func handleCellSelected(cell : CalendarCell, cellState: CellState){
        cell.selectedView.isHidden = cellState.isSelected ? false : true
    }
    
    /** 서버에서 받아오는 정보 달력에 보여주기 (할일) */
    func handleCellEvent(cell: CalendarCell, cellState: CellState){
        cell.eventLabel.isHidden = !eventsFromTheServer.contains { $0.key == formatter.string(from: cellState.date)}
    }
 
}

extension CalendarVC:JTAppleCalendarViewDataSource{
    /** 달력 셀 지정, day 세팅 */
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let myCalendarCell = cell as! CalendarCell
        sharedFunctionToConfigureCell(myCalendarCell: myCalendarCell, cellState: cellState, date: date)
    }
    
    /** 달력 시작과 끝 설정 */
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from : "2018 12 02")!
        let endDate = formatter.date(from : "2019 12 02")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    /** 셀에 일(day) 넣어주기 */
    func sharedFunctionToConfigureCell(myCalendarCell:CalendarCell, cellState: CellState, date: Date){
        myCalendarCell.dateLabel.text! = cellState.text
    }
}

extension CalendarVC:JTAppleCalendarViewDelegate {
    /** cell 에 들어가는 요소 설정해주기 (cellForItemAt) */
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let myCalendarCell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "calendarcell", for: indexPath) as! CalendarCell
        
        myCalendarCell.dateLabel.text! = cellState.text
        configureCell(cell: myCalendarCell, cellState: cellState)
        
        return myCalendarCell
    }
    
    /** 셀을 선택했을 시 동작 */
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(cell: cell, cellState: cellState)
        
        cell?.bounce()
    }
    
    /** 셀을 선택하지않을 시 동작 */
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        configureCell(cell: cell, cellState: cellState)
    }
    
    /** 좌우 스와핑 */
    func calendar(_ calendar:JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo){
        setupCalendarView(dateSegment: visibleDates)
    }
    
    /** 헤더에 요일 설정 */
    func calendar(_ calendar: JTAppleCalendarView, headerViewForDateRange range: (start: Date, end: Date), at indexPath: IndexPath) -> JTAppleCollectionReusableView {
        let header = calendar.dequeueReusableJTAppleSupplementaryView(withReuseIdentifier: "calendarheader", for: indexPath) as! CalendarHeader
        return header
    }
    
    func calendarSizeForMonths(_ calendar: JTAppleCalendarView?) -> MonthSize? {
        return MonthSize(defaultSize: 50)
    }
    
}

/** 임시 서버 정보 받아오기 */
extension CalendarVC {
    func getServerEvents() -> [Date:String]{
        formatter.dateFormat = "yyyy MM dd"
        
        return [
            formatter.date(from:"2018 12 25")!: "happy Birthday",
            formatter.date(from:"2018 12 27")!: "happy Birthday",
            formatter.date(from:"2018 12 28")!: "happy Birthday",
            formatter.date(from:"2018 12 31")!: "happy Birthday",
        ]
    }
}

/** 클릭 시 뛰어오르는 이벤트 */
extension UIView {
    func bounce(){
        self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
        UIView.animate(
            withDuration: 0.5,
            delay: 0, usingSpringWithDamping: 0.3,
            initialSpringVelocity: 0.1,
            options: UIView.AnimationOptions.beginFromCurrentState,
            animations: {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }
}


/** 색 변환기 */
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
