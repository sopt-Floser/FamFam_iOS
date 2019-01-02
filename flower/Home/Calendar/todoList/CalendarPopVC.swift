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

    
    override func viewWillAppear(_ animated: Bool) {
        setSelectDate()
        super.viewWillAppear(animated)
        listTableView.delegate = self
        listTableView.dataSource = self
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
    
    // nn월 nn일 요일
    func setSelectDate(){
        formatter.dateFormat = "MM"
        formatter.locale = Locale(identifier: "ko_KR")
        let tempString = formatter.string(from: selectDate)
        formatter.dateFormat = "dd"
        let tempString2 = formatter.string(from: selectDate)
        formatter.dateFormat = "E"
        let tempString3 = formatter.string(from: selectDate)
        
        let finalString = "\(tempString)월 \(tempString2)일 \(tempString3)"
        dateLabel.text = finalString
    }
}

extension CalendarPopVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "todolistcell", for: indexPath) as! CalendarListCell
        
        print("list color = \(filter[indexPath.row].color)")
        cell.listName.text = filter[indexPath.row].memo
        cell.listColor.backgroundColor = UIColor.init(hex: filter[indexPath.row].color)
        
        return cell
    }
}
