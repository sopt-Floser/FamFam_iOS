//
//  NoticeCell.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 27..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit

class NoticeCell: UICollectionViewCell {
    
    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var noticeTableView: UITableView!
    
    var tempDataBase:[NoticeModel]=[]
    
    func setTempData(){
        var tempData = NoticeModel(noticeImage: "cakeImg", noticeLabel: "생일 축하해!")
        tempDataBase.append(tempData)
        tempData = NoticeModel(noticeImage: "sampleProfile", noticeLabel: "iOS 파트장님!")
        tempDataBase.append(tempData)
    }
    
    override func awakeFromNib() {
        setTempData()
        self.noticeTableView.delegate = self
        self.noticeTableView.dataSource = self
    }
    
    /** 효과 씌우기 */
    override func layoutSubviews() {
        super.layoutSubviews()
        
        layer.shadowRadius = 10
        layer.shadowOpacity = 0.3
        layer.shadowOffset = CGSize(width: 5, height: 10)
        self.clipsToBounds = false
        
        backImage.layer.masksToBounds = true
        backImage.layer.cornerRadius = 15
        
        shadowView.layer.cornerRadius = 15
        noticeTableView.layer.cornerRadius = 15
    }
}

extension NoticeCell : UITableViewDelegate, UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tempDataBase.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let noticeCell : NoticeTableCell = tableView.dequeueReusableCell(withIdentifier: "noticeTableCell") as! NoticeTableCell
        
        let imageString = tempDataBase[indexPath.row]
        
        
        noticeCell.noticeImage.image = tempDataBase[indexPath.row].noticeImage
        noticeCell.noticeLabel.text = tempDataBase[indexPath.row].noticeLabel

        
        return noticeCell
        
    }
    
}
