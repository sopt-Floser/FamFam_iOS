//
//  FirebaseDataService.swift
//  flower
//
//  Created by 성다연 on 2019. 1. 7..
//  Copyright © 2019년 성다연. All rights reserved.
//

import Foundation
import Firebase

// root
fileprivate let baseRef = Database.database().reference()

class FirebaseDataService {
    static let instance = FirebaseDataService()
    
    // 특정 사용자
    let userRef = baseRef.child("user")
    
    // 그룹
    let groupRef = baseRef.child("group")
    
    //message
    let messageRef = baseRef.child("message")
    
    //현재 접속중인 유저 uid
    var currentUserUid: String? {
        get {
            guard let uid = Auth.auth().currentUser?.uid else {
                return nil
            }
            return uid
        }
    }
    
    // 신규 유저 만들기
    func createUserInfoFromAuth(uid:String, userData: Dictionary<String,String>){
        userRef.child(uid).updateChildValues(userData)
    }
    
    // 가입 절차 추가
}
    
//    func signIn(phone withEmail:String, password:String, completion: @escaping() -> Void){
//        Auth.auth().signIn(withEmail: withEmail, password: password, completion: { (user, error) in
//            guard error == nil else {
//            print("Error occurred during sign in")
//            return
//            }
//            completion()
//        })
//   }

