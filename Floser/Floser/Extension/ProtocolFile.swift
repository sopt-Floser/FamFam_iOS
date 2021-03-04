
//
//  ProtoCol.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 11..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation

// 로그인 용 폰넘버
protocol SignUpPhoneNumber {
    func userPhoneNumber(PhoneNumber:String)
}

// 그룹 참여용 코드
protocol GroupJoinCodeNumber {
    func groupCodeNumber(code:String)
}

protocol IAPDelegate {
    func purchaseSuccessful()
    func purchaseCancelled()
    func purchaseFailed()
}

// 피커뷰 날짜 선택
protocol PopupPickerSelectDelegate {
    func selectPicker(date: Date?)
}

// 약관동의 1
protocol sendBtnDataDelegate {
    func sendData(data:Bool)
}

// 약관동의 2
protocol sendBtn2DataDelegate {
    func sendData2(data:Bool)
}
