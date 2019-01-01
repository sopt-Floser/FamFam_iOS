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
        dismiss(animated: true, completion: nil)
    }
    @IBAction func trashBtn(_ sender: UIButton) {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
}

extension AnniversaryVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row == 0){
            // 기념일 추가 셀
            let cell = anniversaryTableView.dequeueReusableCell(withIdentifier: "addAnniversaryCell", for: indexPath) as! addAnniversaryCell
            print("\(indexPath.row) cell setting")
            return cell
        } else if (indexPath.row == 1){
            // 부모님 결혼 기념일 셀
            let cell = anniversaryTableView.dequeueReusableCell(withIdentifier: "marriageAnniversaryCell", for: indexPath) as! marrageAnniversaryCell
            print("\(indexPath.row) cell setting")
            return cell
        }else {
            // 기념일 목록 셀
            let cell = anniversaryTableView.dequeueReusableCell(withIdentifier: "addAnniversaryCell", for: indexPath) as! listAnniversaryCell
            
            let item = AnniversaryDateBase.AnniversaryList[indexPath.row]
            
            cell.anniversaryName.text = item.anniversaryName
            cell.anniversaryDate.text = item.anniversaryDate
            cell.anniversaryDDay.text = item.anniversaryDDay
            print("\(indexPath.row) cell setting")
            return cell
        }

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if (indexPath.row == 0){
            
        } else if (indexPath.row == 1){
            
        }else {
            
        }
    }
    
}
