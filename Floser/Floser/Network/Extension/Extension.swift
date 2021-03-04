//
//  Extension.swift
//  flower
//
//  Created by 성다연 on 2021/03/04.
//  Copyright © 2021 성다연. All rights reserved.
//

import Foundation
import UIKit

extension Date {
    func returnStringValue(format: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return  dateFormatter.string(from: self)
    }
}

extension String {
    func returnDateValue(format: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter.date(from: self)!
    }
}
