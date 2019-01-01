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

var didSwitchDate = false
var filter:[CalendarModel] = [] // 선택한 날짜의 할일을 보관하는 배열

/** calendar 다루는 곳 */
class CalendarVC: UIViewController, UISearchBarDelegate {
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year : UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var switchBtn:UIButton!
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func switchButton(_ sender: UIButton) {
        didSwitchDate = true
        let dvc = storyboard?.instantiateViewController(withIdentifier: "selectPopup") as! CalendarListPopupVC
        present(dvc, animated: true, completion: nil)
    }
    @IBOutlet weak var searchbar: UISearchBar!
    
    
    var takeDate = switchDate // 피커뷰에서 가져온 Date 값
    let todayDate = Date()
    var selectDate = ""
    
    var dateList:[String] = CalendarDatabase.CalendarDateArray // Date(string)만 보관하고 있는 배열
    
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
        calendarView.allowsMultipleSelection = true
        if gesture.state == UIGestureRecognizer.State.began{
        }
    }
    
    var eventsFromTheServer: [String:String] = [:]
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
        
        /** 서버 정보 가져오기 */
        DispatchQueue.global().asyncAfter(deadline: .now() /* 양이 많을 시 시간 추가 + 1 */ ){
            let serverObject = self.getServerEvents()
            for (date) in serverObject{
                let stringDate = self.formatter.string(from: date)
                self.eventsFromTheServer[stringDate] = ""
            }
            DispatchQueue.main.async {
                self.calendarView.reloadData()
            }
        }
    
        calendarView.visibleDates { dateSegment in
            self.setupCalendarView(dateSegment: dateSegment)
        }
    
        calendarView.addGestureRecognizer(longPressGesture)
        
        calendarView.reloadData(withanchor: takeDate){
            let visibleDates = self.calendarView.visibleDates()
        }

        
    }

    
//    func switchCalendar(){
//        print("running")
//        if (didSwitchDate == true){
//            calendarView.scrollToDate(takeDate)
//            print("didswitchDate is true")
//            didSwitchDate = false
//        }
////        calendarView.scrollToDate(takeDate)
//    }
    
    func setupCalendarView(dateSegment: DateSegmentInfo){
        guard let date = dateSegment.monthDates.first?.date else {return}
        
        formatter.dateFormat = "MM"
        month.text = formatter.string(from: date) + "월"
        
        formatter.dateFormat = "yyyy"
        year.text = formatter.string(from: date) + "년"
        
        calendarView.ibCalendarDelegate = self
        calendarView.ibCalendarDataSource = self
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.isRangeSelectionUsed = true
        //calendarView.sectionInset = UIEdgeInsets(top: 22, left: 22, bottom: 22, right: 22)
    }
    
    
    func configureCell(cell: JTAppleCell?, cellState: CellState){
        guard let myCalendarCell = cell as? CalendarCell else {return}
        formatter.dateFormat = "yyyy MM dd"
        
        handleCellTextColor(cell: myCalendarCell, cellState: cellState)
        handleCellSelected(cell: myCalendarCell, cellState: cellState)
        handleCellThisMonth(cell: myCalendarCell, cellState: cellState)
        handleCellEvent(cell: myCalendarCell, cellState: cellState)
    }
    
//    func setInitialPostDatesOnCalendarView() {
//        guard let post = MyObjects.sharedInstance.workingPostViewModel?.post,
//            let prep = post.prepDate,
//            let deliver = post.deliverDate,
//            let dateRange = self.calendarView?.generateDateRange(from: prep, to: deliver) else {
//                return
//        }
//        calendarView?.scrollToDate(deliver, animateScroll:false)
//        calendarView?.selectDates(dateRange)
//    }
    
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
    
    /** 다른 달 회색으로 */
    func handleCellThisMonth(cell:CalendarCell, cellState: CellState){
        if (cellState.dateBelongsTo != .thisMonth ) {
            cell.dateLabel.textColor = UIColor.lightGray
        }
    }
    
    /** 날짜 선택 시 이벤트 */
    func handleCellSelected(cell : CalendarCell, cellState: CellState){
        cell.selectedView.isHidden = cellState.isSelected ? false : true
    }
    
    /** 서버에서 받아오는 정보 달력에 보여주기 (할일) */
    func handleCellEvent(cell: CalendarCell, cellState: CellState){
        cell.eventView.isHidden = !eventsFromTheServer.contains { $0.key == formatter.string(from: cellState.date)}
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
        calendarView.allowsMultipleSelection = false
        
        selectDate = formatter.string(from: cellState.date)
        print("selectDate = \(selectDate)")
        filter = CalendarDatabase.CalendarDataArray.filter{$0.date == selectDate  }
        print("filter = \(filter)")
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
    
    // 취소버튼 클릭 시 키보드 닫히고 검색어 초기화
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchbar.text = ""
        searchbar.resignFirstResponder()
        
    }
}

// 임시 서버 정보 받아오기
extension CalendarVC {
    func getServerEvents() -> [Date]{
        formatter.dateFormat = "yyyy MM dd"

        return [
            formatter.date(from:dateList[0]) ?? Date(),
            formatter.date(from:dateList[1]) ?? Date(),
            formatter.date(from:dateList[2]) ?? Date(),
            formatter.date(from:dateList[3]) ?? Date(),
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

