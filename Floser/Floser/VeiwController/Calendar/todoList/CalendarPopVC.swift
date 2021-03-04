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
    let selectDate = Date()
    private var delegate : CalendarVCDelegate?
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpSelectDate()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegate()
        setUpGesture()
    }
}


extension CalendarPopVC {
    func setUpDelegate(){
        listTableView.delegate = self
        listTableView.dataSource = self
    }
    
    func setUpSelectDate(){
        dateLabel.text = selectDate.returnStringValue(format:  "MM월 dd일 E")
    }
    
    func setUpGesture(){
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap(sender: )))
        outsideView.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleTap(sender: UITapGestureRecognizer){
        dismiss(animated: true, completion: nil)
    }
}


extension CalendarPopVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (delegate?.filterValue.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: "todolistcell", for: indexPath) as! CalendarListCell

        if let dele = delegate {
            cell.listName.text = dele.filterValue[indexPath.row].memo
            cell.listColor.backgroundColor = UIColor.init(hex: dele.filterValue[indexPath.row].color)
        }
        
        return cell
    }
}
