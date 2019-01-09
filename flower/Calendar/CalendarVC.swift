//
//  calenderVC.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 23..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit
import JTAppleCalendar


/** 전역 변수 */
var filter:[CalendarModel] = [] // 선택한 날짜의 할일을 보관하는 배열
var selectDate = Date()
var searchedData:[CalendarModel] = [] // 검색어에 따른 목록

protocol IAPDelegate {
    func purchaseSuccessful()
    func purchaseCancelled()
    func purchaseFailed()
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
    
    /** 지역 변수 */
    let todayDate = Date()
    var eventsFromTheServer: [String] = []
    var dateList:[String] = CalendarDatabase.CalendarDateArray // Date(string)만 보관하고 있는 배열
    var serverAllDate:Calendar_Month?
    

    /** 날,월,일 변환기 */
    let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = Calendar.current.timeZone
        dateFormatter.locale = Calendar.current.locale
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        return dateFormatter
    }()
    
    /** 터치 인식기 */
    let longPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPress(gesture:)))
    
    @objc func handleLongPress(gesture: UILongPressGestureRecognizer){
        print("long press")
        calendarView.allowsMultipleSelection = true
        if gesture.state == UIGestureRecognizer.State.began{
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        let bringDate = formatter.string(from: Date())
        
        CalendarService.shared.getCalendarMonthList(dateStr: bringDate){ (data) in
            guard let value = data.status else {return}
            print("============ calendar value = \(value)===========")
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
        
        print("calendarview will appear = \(bringDate)")
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchbar.delegate = self
        searchTV.delegate = self
        searchTV.dataSource = self
        
        /** 서버 정보 가져오기 */
        // \서버에서 Date 형식의 날짜 받아올 시 띄울 예정
        DispatchQueue.global().asyncAfter(deadline: .now() /* 양이 많을 시 시간 추가 + 1 */ ){
            guard let serverDates = self.serverAllDate else {return}
            let familydate = self.serverAllDate
            
//            var list:[String] = familydate?.familys.map({ (dates:[String]) -> [String] in
//                return dates
//            })
            
            for (date) in CalendarDatabase.CalendarDateArray{
                self.eventsFromTheServer.append(date)
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
            
            formatter.dateFormat = "MM 월"
            month.text = formatter.string(from: date)
            
            formatter.dateFormat = "yyyy 년"
            year.text = formatter.string(from: date)
            
            calendarView.ibCalendarDelegate = self
            calendarView.ibCalendarDataSource = self
            calendarView.minimumLineSpacing = 0
            calendarView.minimumInteritemSpacing = 0
            calendarView.isRangeSelectionUsed = true
    }
    
    
    func configureCell(cell: JTAppleCell?, cellState: CellState){
        guard let myCalendarCell = cell as? CalendarCell else {return}
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        
        handleCellTextColor(cell: myCalendarCell, cellState: cellState)
        handleCellSelected(cell: myCalendarCell, cellState: cellState)
        handleCellThisMonth(cell: myCalendarCell, cellState: cellState)
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
        var eventCount = 0
        //eventsFromTheServer.map(formatter.string(from: cellState.date))
        if (eventsFromTheServer.contains(formatter.string(from: cellState.date))){
            eventCount += 1
        }
       
        
        
        switch eventCount {
        case 1:
            cell.eventLabel.isHidden = false
            cell.eventLabel2.isHidden = true
            cell.eventLabel3.isHidden = true
        case 2:
            cell.eventLabel.isHidden = false
            cell.eventLabel2.isHidden = false
            cell.eventLabel3.isHidden = true
        case 3:
            cell.eventLabel.isHidden = false
            cell.eventLabel2.isHidden = false
            cell.eventLabel3.isHidden = false
        default:
            cell.eventLabel.isHidden = true
            cell.eventLabel2.isHidden = true
            cell.eventLabel3.isHidden = true
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
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = Date()//formatter.date(from : "2018 12 02")!
        let endDate = formatter.date(from : "2019-12-02T00:00")!
        
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
        
        let stringSelectDate = formatter.string(from: cellState.date)
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
        searchedData = searchText.isEmpty ? searchedData : CalendarDatabase.CalendarDataArray.filter{ $0.memo.range(of: searchText) != nil
        }
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
        print("selected date: \(date)")
        calendarView.reloadData(withanchor: date)
    }
}

extension CalendarVC {
    // 날짜 사이의 날짜 가져오기
    func daysBetweenDates(startDate: Date, endDate: Date) -> Int
    {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: startDate, to: endDate)
        return components.day!
    }
}

// 임시 서버 정보 받아오기
//extension CalendarVC {
//    func getServerEvents() -> [Date]{
//        formatter.dateFormat = "yyyy MM dd"
//        var rValue = [Date]()
//        let count = dateList.count
//
//        for i in dateList {
//            rValue.append(formatter.date(from: dateList[i]) ?? Date())
//        }
//
//
//    }
//}

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
    convenience init(hex: String){
        var cString: String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        var rgbValue:UInt32 = 0
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        Scanner(string:cString).scanHexInt32(&rgbValue)
        
        self.init(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
}


