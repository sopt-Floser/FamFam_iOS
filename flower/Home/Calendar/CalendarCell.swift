//
//  CalendarCellCollectionViewCell.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 23..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit
import JTAppleCalendar

class CalendarCell: JTAppleCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var selectedView: UIView!
    @IBOutlet weak var eventLabel : UILabel!
}
