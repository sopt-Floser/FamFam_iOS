//
//  CalendarPopup.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 24..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit
import Foundation

class CalendarPopVC: UIViewController {
    @IBOutlet weak var popView: UIView!
    @IBOutlet weak var outsideView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var listTableView: UITableView!
    
    // 임시 배열
    let dateList = CalendarDatabase.CalendarDataArray // 할일 모든 정보
    let formatter = DateFormatter()
    var formateDate = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        listTableView.delegate = self
        listTableView.dataSource = self
        setSelectDate()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender: )))
        outsideView.addGestureRecognizer(tapGesture)
    }
    
    /** 터치 리스너, 화면 내리기 */
    @objc func handleTap(sender: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
    
    func setSelectDate(){
        formatter.dateFormat = "MM"
        //formatter.locale = Locale(identifier: "ko_KR")
        var tempString = formatter.date(from: formateDate)
        formatter.dateFormat = "dd"
        var tempString2 = formatter.date(from: formateDate)
        formatter.dateFormat = "E"
        var tempString3 = formatter.date(from: formateDate)
        
        var finalString = "\(tempString)월 \(tempString2)일 \(tempString3)"
        
        print("finalString = \(finalString), \(formateDate)")
    }
}

extension CalendarPopVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todolistcell", for: indexPath) as! CalendarListCell
        
        let memo = filter[indexPath.row].memo
        let color = filter[indexPath.row].color
        print("filter = \(filter[indexPath.row].memo),  \(filter[indexPath.row].date), \(indexPath.row)")
        
//        cell.listName.text = memo
//        cell.listColor.backgroundColor = UIColor.blue
        
        return cell
    }
}
