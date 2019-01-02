//
//  AnniversaryVC.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 1..
//  Copyright © 2019년 성다연. All rights reserved.
//

import UIKit

class AnniversaryVC: UIViewController {
    @IBOutlet weak var anniversaryTableView: UITableView!
    @IBAction func backBtn(_ sender: UIButton) {
//        navigationController?.popViewController(animated: true)
        dismiss(animated: true)
    }
    @IBAction func trashBtn(_ sender: UIButton) {
    }
    @IBAction func marrageBtn(_ sender: UIButton) {
        let dvc = storyboard?.instantiateViewController(withIdentifier: "selectPopup") as! CalendarListPopupVC
        present(dvc, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        
        anniversaryTableView.delegate = self
        anniversaryTableView.dataSource = self
        
        super.viewDidLoad()
    }
}

extension AnniversaryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("AnniversaryDatabase count = \(AnniversaryDateBase.AnniversaryList.count)")
        return AnniversaryDateBase.AnniversaryList.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0){
            // 기념일 추가 셀
            let cell = anniversaryTableView.dequeueReusableCell(withIdentifier: "addAnniversaryCell", for: indexPath) as! addAnniversaryCell
            print("\(indexPath.row) cell setting")
            return cell
        } else if (indexPath.row == 1){
            // 부모님 결혼 기념일 셀
            let cell = anniversaryTableView.dequeueReusableCell(withIdentifier: "marriageAnniversaryCell", for: indexPath) as! marriageAnniversaryCell
            print("\(indexPath.row) cell setting")
            return cell
        }else {
            // 기념일 목록 셀
            let cell = anniversaryTableView.dequeueReusableCell(withIdentifier: "listAnniversaryCell", for: indexPath) as! listAnniversaryCell
            
            let item = AnniversaryDateBase.AnniversaryList[indexPath.row - 2]

            cell.anniversaryName.text = item.anniversaryName
            cell.anniversaryDate.text = item.anniversaryDate
            cell.anniversaryDDay.text = item.anniversaryDDay
            print("index = \(indexPath.row)")
            print("\(indexPath.row) cell setting")
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row == 0){
            //기념일 추가창으로 이동
        } else if (indexPath.row == 1){
            // 날짜 선택 popup 띄우기
        }else {
            // 선택 불가능
        }
    }
    
}
