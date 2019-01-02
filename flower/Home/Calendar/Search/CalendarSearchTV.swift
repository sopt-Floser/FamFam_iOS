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
    
    override func viewDidLoad() {
        searchTableView.delegate = self
        searchTableView.dataSource = self
        self.searchTableView.reloadData()
        super.viewDidLoad()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedData.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = searchTableView.dequeueReusableCell(withIdentifier: "calendarSearchCell", for: indexPath) as! CalendarSearchCell
        let item = searchedData[indexPath.row]
        cell.searchDate.text = item.date
        cell.searchLunarDate.text = "음력"
        cell.searchMemo.text = item.memo
        cell.searchColor.backgroundColor = UIColor.init(hex: item.color)
        
        return cell
    }
}
