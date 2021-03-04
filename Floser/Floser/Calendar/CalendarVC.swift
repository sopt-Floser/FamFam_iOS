//
//  calenderVC.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 23..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit
import JTAppleCalendar

protocol CalendarVCDelegate {
    var selectedDate : Date { get set }
    var filterValue : [CalendarModel] { get set }
    var searchDataValue : [CalendarModel] { get set }
}

/** calendar 다루는 VC */
class CalendarVC: UIViewController {
    @IBOutlet weak var searchTV: UITableView!
    @IBOutlet weak var calendarView: JTAppleCalendarView!
    @IBOutlet weak var year : UILabel!
    @IBOutlet weak var month: UILabel!
    @IBOutlet weak var switchBtn:UIButton!
    
    @IBAction func switchButton(_ sender: UIButton) {
        let dvc = storyboard?.instantiateViewController(withIdentifier: "selectPopup") as! CalendarListPopupVC
        dvc.delegate = self
        present(dvc, animated: true, completion: nil)
    }
    
    @IBOutlet weak var searchbar: UISearchBar!
    
    let todayDate = Date()
    var eventsFromTheServer: [String] = []
    var eventsFromTheLocal: [String:String] = [:]
    var dateList:[String] = CalendarDatabase.CalendarDataArray.map { $0.date }
    var serverAllDate:Calendar_Month?
    
    var filter: [CalendarModel] = [] // 선택한 날짜의 할일을 보관하는 배열
    var selectDate = Date()
    var searchedData: [CalendarModel] = [] // 검색어에 따른 목록
    
    private var delegate : CalendarListPopupVCDelegate?

    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        let bringDate = Date().returnStringValue(format: "yyyy MM dd")
        
        CalendarService.shared.getCalendarMonthList(dateStr: bringDate){ (data) in
            guard let value = data.status else {return}
            switch value {
            case 200 :
                guard let calendar = data.data else { return }
                self.serverAllDate = calendar
                print("일정 조회 성공")
            case 500 :
                print("서버 내부 에러")
            case 600 :
                print("데이터베이스 에러")
            default :
                print("서버통신 - 월별 일정 가져오기")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
        searchTV.delegate = self
        searchTV.dataSource = self
        
        
        DispatchQueue.global().asyncAfter(deadline: .now() /* 양이 많을 시 시간 추가 + 1 */ ){ [weak self] in
            let dateArray = CalendarDatabase.CalendarDataArray.map { $0.date }
            for date in dateArray {
                self?.eventsFromTheLocal[date] = ""
            }
            DispatchQueue.main.async { [weak self] in
                self?.calendarView.reloadData()
            }
        }
    
        calendarView.visibleDates { dateSegment in
            self.setupCalendarView(dateSegment: dateSegment)
        }
        
        
        if let dele = delegate {
            calendarView.reloadData(withanchor: dele.selectDate){
                let visibleDates = self.calendarView.visibleDates()
            }
        }
        /** 터치 인식기 */
        let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
    
        calendarView.addGestureRecognizer(longPressGesture)
    }
}

extension CalendarVC : CalendarVCDelegate {
    var selectedDate: Date {
        get {
            return selectDate
        }
        set {
            selectDate = newValue
        }
    }
    
    var filterValue: [CalendarModel] {
        get {
            return filter
        }
        set {
            filter = newValue
        }
    }
    
    var searchDataValue: [CalendarModel] {
        get {
            return searchedData
        }
        set {
            searchedData = newValue
        }
    }
    
    func setupCalendarView(dateSegment: DateSegmentInfo){
        guard let date = dateSegment.monthDates.first?.date else {return}
        month.text = date.returnStringValue(format: "MM 월")
        year.text = date.returnStringValue(format: "yyyy 년")
        
        calendarView.ibCalendarDelegate = self
        calendarView.ibCalendarDataSource = self
        calendarView.minimumLineSpacing = 0
        calendarView.minimumInteritemSpacing = 0
        calendarView.isRangeSelectionUsed = true
    }
    
    
    func configureCell(cell: JTAppleCell?, cellState: CellState){
        guard let myCalendarCell = cell as? CalendarCell else { return }
        
        handleCellTextColor(cell: myCalendarCell, cellState: cellState)
        handleCellSelected(cell: myCalendarCell, cellState: cellState)
        handleCellThisMonth(cell: myCalendarCell, cellState: cellState)
        handleCellEvent(cell: myCalendarCell, cellState: cellState)
    }
    
    /** 달력 일 색갈 변환기 */
    func handleCellTextColor(cell: CalendarCell, cellState: CellState){
        let todayDateString = todayDate.returnStringValue(format: "yyyy MM dd")
        let monthDateString = cellState.date.returnStringValue(format: "yyyy MM dd")
        
        // 오늘 = 오렌지색
        if todayDateString == monthDateString {
            cell.dateLabel.textColor = UIColor.orange
        } else { // 선택한 날
           cell.dateLabel.textColor = cellState.isSelected ? UIColor.white : UIColor.black
        }
    }
    
    /** 다른 달 회색으로 */
    func handleCellThisMonth(cell:CalendarCell, cellState: CellState){
        if cellState.dateBelongsTo != .thisMonth {
            cell.dateLabel.textColor = UIColor.lightGray
        }
    }
    
    /** 날짜 선택 시 이벤트 */
    func handleCellSelected(cell : CalendarCell, cellState: CellState){
        cell.selectedView.isHidden = cellState.isSelected ? false : true
    }
    
    /** 서버에서 받아오는 정보 달력에 보여주기 (할일) */
    func handleCellEvent(cell: CalendarCell, cellState: CellState){
        cell.eventLabel.isHidden = !eventsFromTheLocal.contains{ $0.key == cellState.date.returnStringValue(format: "yyyy MM dd")}
    }
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer){
        calendarView.allowsMultipleSelection = true
        if gesture.state == UIGestureRecognizer.State.began{
        }
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
        let startDate = Date()
        let endDate = "2019 12 02".returnDateValue(format: "yyyy MM dd")
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
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
        
        let stringSelectDate = cellState.date.returnStringValue(format: "yyyy MM dd")
        selectDate = cellState.date
        filter = CalendarDatabase.CalendarDataArray.filter{$0.date == stringSelectDate  }
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

/** 서치 바 */
extension CalendarVC:UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTV.dequeueReusableCell(withIdentifier: "calendarSearchCell", for: indexPath) as! CalendarSearchCell
        let item = searchedData[indexPath.row]
        
        cell.searchDate.text = item.date
        cell.searchLunarDate.text = "음력"
        cell.searchMemo.text = item.memo
        cell.searchColor.backgroundColor = UIColor.init(hex: item.color)
        
        return cell
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchedData = searchText.isEmpty ? searchedData :
            CalendarDatabase.CalendarDataArray.filter { $0.memo.range(of: searchText) != nil }
        searchTV.reloadData()
    }
    
    // 취소버튼 클릭 시 키보드 닫히고 검색어 초기화
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchbar.text = ""
        searchbar.resignFirstResponder()
        searchTV.isHidden = true
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchTV.isHidden = false
        searchBar.showsCancelButton = true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchbar.showsCancelButton = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchbar.resignFirstResponder()
        searchbar.endEditing(true)
    }
}

extension CalendarVC: PopupPickerSelectDelegate {
    func selectPicker(date: Date?) {
        calendarView.reloadData(withanchor: date)
    }
    
    func daysBetweenDates(startDate: Date, endDate: Date) -> Int {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return components.day!
    }
}


class CalendarHeader: JTAppleCollectionReusableView {
}
