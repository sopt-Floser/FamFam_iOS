//
//  ChatVC.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 26..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit
import Firebase

class ChatVC: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var chatView: UIView!
    @IBOutlet weak var plusBtn: UIButton!
    @IBOutlet weak var item: UINavigationItem!
    @IBOutlet weak var chatCollectionView: UICollectionView!
    //@IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var chatTF:UITextField!
    
    var messages : [ChatMessage] = [ChatMessage(fromUserId: "", text: "", timestamp: 0)]
    var keyboardShown:Bool = false
    var originY:CGFloat? // 오브젝트의 기본 위치
    
    var groupKey: String? {
        didSet {
            if let key = groupKey {
                print("groupKey = \(groupKey)")
                fetchMessages()
                FirebaseDataService.instance.groupRef.child(key).observeSingleEvent(of: .value, with: { (snapshot) in
                    if let data = snapshot.value as? Dictionary<String, AnyObject> {
                        if let title = data["name"] as? String {
                            self.item.title = title
                        }
                    }
                })
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "chatCell", for: indexPath) as! ChatMessageCell
        let message = messages[indexPath.item]
        cell.textLabel.text = message.text
        setupChatCell(cell: cell, message: message)
        
        if message.text.characters.count > 0 {
            cell.containerViewWidthAnchor?.constant = measuredFrameHeightForEachMessage(message: message.text).width + 32
        }
        return cell
    }
    
    // sizeForItemAt, 유저에 따라 다른 말풍선
    func setupChatCell(cell: ChatMessageCell, message: ChatMessage) {
        if message.fromUserId == FirebaseDataService.instance.currentUserUid {
            cell.containerView.backgroundColor = UIColor.magenta
            cell.textLabel.textColor = UIColor.white
            cell.containerViewRightAnchor?.isActive = true
            cell.containerViewLeftAnchor?.isActive = false
        } else {
            cell.containerView.backgroundColor = UIColor.lightGray
            cell.textLabel.textColor = UIColor.black
            cell.containerViewRightAnchor?.isActive = false
            cell.containerViewLeftAnchor?.isActive = true
        }
    }

    private func measuredFrameHeightForEachMessage(message: String) -> CGRect {
        let size = CGSize(width: 200, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: message).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)], context: nil)
    }
    
    // 메시지를 보내면 파베 데이터베이스에 채팅 메시지가 기록되어야함
    @IBAction func sendButtonTapped(_ sender: UIButton) {
        print("send Tapped!")
        print("currentUserId = \(FirebaseDataService.instance.currentUserUid)")
        print("currentGroupId = \(FirebaseDataService.instance.groupRef)")
        
        let ref = FirebaseDataService.instance.messageRef.childByAutoId()
        guard let fromUserId = FirebaseDataService.instance.currentUserUid else {
            return
        }
        print("user = \(fromUserId)")
        
        let data: Dictionary<String, AnyObject> = [
            "fromUserId": fromUserId as AnyObject,
            "text": chatTF.text! as AnyObject,
            "timestamp": NSNumber(value: Date().timeIntervalSince1970)
        ]
        
        ref.updateChildValues(data) { (err, ref) in
            guard err == nil else {
                print(err as Any)
                return
            }
            
            self.chatTF.text = nil
            if let groupId = self.groupKey {
                FirebaseDataService.instance.groupRef.child(groupId).child("messages").updateChildValues([ref.key: 1])
            }
        }
    }
    
    func handleSend(){
        let ref = FirebaseDataService.instance.messageRef.child("message")
        let childRef = ref.childByAutoId()
        
//        let toId
        let fromId = Auth.auth().currentUser?.uid
//        let timeStamp:NSNumber = (NSDate.timeIntervalSinceReferenceDate)
//        let values = ["text":chatTF.text!, "toId": toId,"fromId":fromId, "timestamp":timeStamp]
//        childRef.updateChildValues(values)
    }
    
    @IBAction func collectionViewTapped(_ sender: Any) {
        chatTF.resignFirstResponder()
    }
    
    // 그룹 키를 이용하여 채팅방의 레퍼런스를 얻고, 이 레퍼런스를 활용하여 채팅방의 기본정보와 이 방안에서 이루어진 모든 채팅 메시지를 가져오기
    func fetchMessages() {
        if let groupId = self.groupKey {
            print("groupId passed")
            
            let groupMessageRef = FirebaseDataService.instance.groupRef.child(groupId).child("messages")
            groupMessageRef.observe(.childAdded, with: { (snapshot) in
                let messageId = snapshot.key
                let messageRef = FirebaseDataService.instance.messageRef.child(messageId)
                messageRef.observeSingleEvent(of: .value, with: { (snapshot) in
                    guard let dict = snapshot.value as? Dictionary<String, AnyObject> else {
                        return
                    }
                    let message = ChatMessage(
                        fromUserId: dict["fromUserId"] as! String,
                        text: dict["tet"] as! String,
                        timestamp: dict["timestamp"] as! NSNumber
                    )
                    self.messages.insert(message, at: self.messages.count - 1)
                    self.chatCollectionView.reloadData()
                    if self.messages.count >= 1 {
                        let indexPath = IndexPath(item: self.messages.count - 1, section: 0)
                        //self.chatCollectionView.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: true)
                    }
                })
            })
        }
    }
    
    @objc func plusButton(){
        // 이모티콘
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        registerForKeyboardNotifications()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatTF.delegate = self
        chatTF.resignFirstResponder()
        //chatTF.addTarget(self, action: #selector(keyboardShown), for: .touchUpInside)
        plusBtn.addTarget(self, action: #selector(plusButton), for: .touchUpInside)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unregisterForKeyboardNotifications()
    }

}

extension ChatVC {
    
    private func registerUserInfoDatabaseWithUID(uid:String, values:[String: AnyObject]){
        let ref = Firebase.Database.database().reference(fromURL: "https://famfam-9602e.firebaseio.com/")
        let userReference = ref.child("users").child(uid)
    }
    
    func registerForKeyboardNotifications() {
        // 옵저버 등록
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    
    func unregisterForKeyboardNotifications() {
        // 옵저버 등록 해제
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(note: NSNotification) {
        if let keyboardSize = (note.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue.size {
            if keyboardSize.height == 0.0 || keyboardShown == true {
                return
            }
            
            print("keyboard will show")
            UIView.animate(withDuration: 0.33, animations: { () -> Void in
                
//                if self.originY == nil { self.originY = self.chatView.frame.origin.y }
//                self.chatView.frame.origin.y = self.originY! - keyboardSize.height
                self.view.frame.origin.y -= keyboardSize.height
            })
            keyboardShown = true
        }
    }
    
    @objc func keyboardWillHide(note: NSNotification) {
        if let keyboardSize = (note.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                if keyboardShown == false {
                    return
                }
            
                print("keyboard will hide")
                UIView.animate(withDuration: 0.33, animations: { () -> Void in
//                    guard let originY = self.originY else { return }
//                    self.chatView.frame.origin.y = originY
                    self.view.frame.origin.y = 0
                })
                keyboardShown = false
            }
        }
}
