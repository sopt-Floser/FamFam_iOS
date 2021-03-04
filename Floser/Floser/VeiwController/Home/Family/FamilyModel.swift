//
//  FamilyModel.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 30..
//  Copyright © 2018년 성다연. All rights reserved.
//
import UIKit
import Foundation

struct FamilyModel {
    var familyImage: UIImage!
    var familyName: String
    
    init(image:String, name:String){
        self.familyImage = UIImage(named: image)
        self.familyName = name
    }
}
