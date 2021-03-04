//
//  CalendarSearchTV.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 2..
//  Copyright © 2019년 성다연. All rights reserved.
//

import UIKit
import Foundation

class CalendarSearchTV: UITableViewController {
    @IBOutlet var searchTableView: UITableView!
    
    private var delegate : CalendarVCDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        searchTableView.delegate = self
        searchTableView.dataSource = self
    }
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let dele = delegate {
            return dele.searchDataValue.count
        }
        return 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "calendarSearchCell", for: indexPath) as! CalendarSearchCell
        
        if let dele = delegate {
            let item = dele.searchDataValue[indexPath.row]
            
            cell.searchDate.text = item.date
            cell.searchMemo.text = item.memo
            cell.searchColor.backgroundColor = UIColor.init(hex: item.color)
        }
        cell.searchLunarDate.text = "음력"
        
        return cell
    }
}
