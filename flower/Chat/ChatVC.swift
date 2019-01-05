//
//  ChatVC.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 26..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit
import Firebase

class ChatVC: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var ChatTableView: UITableView!
    @IBOutlet weak var chatTF: UITextField!
    @IBAction func chatSendBtn(_ sender: UIButton) {
    }


    override func viewDidAppear(_ animated: Bool) {
        self.chatTF.becomeFirstResponder() // 텍스트 필드에 포커스
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        chatTF.delegate = self
    }
}

extension ChatVC : UITableViewDelegate{
    
}

extension ChatVC : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ChatTableView.dequeueReusableCell(withIdentifier: "otherChatCell", for: indexPath) as! OtherChatCell
        cell.otherChatImage.image = UIImage(named: "")
        cell.otherChatName.text = ""
        cell.otherChatMessage.text = ""
        
        return cell
    }
}

extension ChatVC {
//    func text
}
