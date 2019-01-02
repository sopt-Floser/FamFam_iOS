//
//  FullPostVC.swifttodayReplyCelltodayNewReplyCell
//  flower
//
//  Created by 김지민 on 28/12/2018.
//  Copyright © 2018 성다연. All rights reserved.
//

import UIKit

class PostFullVC: UIViewController {
    
    
    //게시글 테이블
    
    
    @IBOutlet var postFullTable: UITableView!
    
    var postProfileImage: String? //UIImage?
    var postName: String?
    var postDate: String?
    var postImage: String? //UIImage?
    var postImagePageControl: Int?
    var emotionImage: String? //UIImage?
    var emotionName: String?
    var postContent: String?
    var replyCount: String?

    //댓글 보기 테이블
    
    
    //댓글 달기 테이블

    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        postFullTable.delegate = self
        postFullTable.dataSource = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }

}

extension PostFullVC: UITableViewDataSource {
    //게시글
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0 :
            return 1
        case 1 :
            print("replyCount = \(replyCount)")
            return Int(replyCount!)!
        default:
            return 1
        }
        
    }
    
    func tableView(_ tablaView: UITableView, heightForSectionAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0 :
            return 527
        case 1 :
            return 55
        default:
            return 55
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        switch indexPath.section {
        case 0 :
            return 527
        case 1 :
            return 55
        default:
            return 55
        }

    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    }
}
       // if indexPath.row == 0 {
        
            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PostFullCell") as! PostFullCell
//
//
//            cell.postProfileImageView?.image = UIImage(named: postProfileImage!)
//
//            cell.postNameView.text = postName
//            cell.postDateView.text = postDate
//
//            cell.postImageView?.image = UIImage(named: postImage!)
//
//
//            cell.emotionImageView?.image = UIImage(named: emotionImage!)
//
//            cell.emotionNameView.text = emotionName
//
//            cell.postContentView.text = postContent
//            cell.replyCountView.text = replyCount
//
//
//            return cell
//        } else if indexPath.row == 1 {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PostReplyCell") as! PostReplyCell
//
//            return cell
//        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "PostNewReply") as! PostNewReplyCell
//
//            return cell
//        }


extension PostFullVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Hi")
        
    }
}
