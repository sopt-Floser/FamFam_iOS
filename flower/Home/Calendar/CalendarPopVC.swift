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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        /** 일정 추가 뷰 바깥 영역 인식 */
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender: )))
        outsideView.addGestureRecognizer(tapGesture)
    }
    
    /** 터치 리스너, 화면 내리기 */
    @objc func handleTap(sender: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}

extension CalendarPopVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filter.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "todolistcell", for: indexPath) as! CalendarListCell
        
        print("filter = \(filter[indexPath.row].memo),  \(filter[indexPath.row].color)")
        
        cell.listName.text = filter[indexPath.row].memo
//        cell.listColor.backgroundColor = UIColor.blue
        
        
        return cell
    }
    
    
}
