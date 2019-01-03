//
//  FullPostVC.swifttodayReplyCelltodayNewReplyCell
//  flower
//
//  Created by 김지민 on 28/12/2018.
//  Copyright © 2018 성다연. All rights reserved.
//

import UIKit

var postReplyList: [PostReplyData] = []
class PostFullVC: UIViewController {
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        getsetPostData() //게시글 데이터 앞 페이지에서 받아오고 세팅하는 함수
        setPostReplyData()//댓글 데이터 받아오는 함수
        //게시글에 적용은 cellForRowAt 에서 set
        newReplyViewShadow() // 댓글 달기창 그림자 설정 함수
        
        postFullTable.delegate = self
        postFullTable.dataSource = self
    
//        self.tabBarController?.tabBar.isHidden = true
    }

    
    //게시글
    var postProfileImage: String?
    var postName: String?
    var postDate: String?
    var postImage: String?
    var postImagePageControl: Int!
    var emotionImage: String?
    var emotionName: String?
    var postContent: String?
    var replyCount: Int!
    
    @IBOutlet var postFullTable: UITableView!
    
    @IBOutlet var postProfileImageView: UIImageView!
    @IBOutlet var postNameView: UILabel!
    @IBOutlet var postDateView: UILabel!
    @IBOutlet var postImageView: UIImageView!
    @IBOutlet var postImagePageControlView: UIPageControl!
    @IBOutlet var emotionImageView: UIImageView!
    @IBOutlet var emotionNameView: UILabel!
    @IBOutlet var postContentView: UILabel!
    @IBOutlet var replyCountView: UILabel!
    
    func getsetPostData(){
        
        postProfileImageView.image = UIImage(named:postProfileImage!)
        postNameView.text = postName
        postDateView.text = postDate
        postImageView.image = UIImage(named:postImage!)
        postImagePageControlView.numberOfPages = postImagePageControl
        emotionImageView.image = UIImage(named:emotionImage!)
        emotionNameView.text = emotionName
        postContentView.text = postContent
        replyCountView.text = String(replyCount)
    }


    //댓글 보기
    
    
    //댓글 달기
    
    
    //// 현재 임시로 스토리보드에서 위치 -값을 주는 형식으로 댓글 다는 창 위치를 탭바 위치로 옮겼는데 문제 생길 수도 있으니까 파트장님꼐 여쭤봐야함
    
    @IBOutlet var newReplyView: UIView!
    
    func newReplyViewShadow(){
    newReplyView.layer.shadowColor = UIColor.darkGray.cgColor
    newReplyView.layer.shadowOpacity = 10
    newReplyView.layer.shadowOffset = CGSize.zero
    newReplyView.layer.shadowRadius = 5
    newReplyView.layer.shadowPath = UIBezierPath(rect: newReplyView.bounds).cgPath
    newReplyView.layer.shouldRasterize = true
    }
    
    
    ///
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
    }

}

extension PostFullVC: UITableViewDataSource,UITableViewDelegate {
    //게시글
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
        
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0 :
            return 0
        case 1 :
            return Int(replyCount)
        default :
            return 0
        }
    }
    
//    func tableView(_ tablaView: UITableView, heightForSectionAt indexPath: IndexPath) -> CGFloat {
//
//        switch indexPath.section {
//        case 0 :
//            return 527
//        case 1 :
//            return 55
//        default:
//            return 55
//        }
//    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//
//        switch indexPath.section {
//        case 0 :
//            return 527
//        case 1 :
//            return 55
//        default:
//            return 55
//        }
//
//    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        
        func stringOptionalUnwork(_ value: String?) -> String{
            guard let value_ = value else {
                return ""
            }
            return value_
        }
        
        //cell 객체를 선언합니다. reusable identifier를 제대로 설정해주는거 잊지마세요!
        let cell = postFullTable.dequeueReusableCell(withIdentifier: "PostReplyCell") as! PostReplyCell
        //각 row에 해당하는 cell의 데이터를 넣어주기위해 모델에서 reply 데이터 하나를 선언합니다.
        let reply = postReplyList[indexPath.row]
        //위에서 가져온 데이터를 각 cell에 넣어줍니다.

        var checkimage = reply.replyImage
        cell.replyImage?.image = UIImage(named:stringOptionalUnwork(checkimage))
        
        cell.replyName.text = reply.replyName
        cell.replyContent.text = reply.replyContent
        // 중간 (게시글)
        
        //위의 과정을 마친 cell 객체를 반환합니다.
        return cell
    }
}

extension PostFullVC {
    func setPostReplyData() {
        let reply1 = PostReplyData(profile: "sampleProfile", replier: "승수", comment: "완전 추워")
        let reply2 = PostReplyData(profile: "cakeImg", replier: "케이크", comment: "케이크 드세요")
        let reply3 = PostReplyData(profile: "momPic", replier: "엄마", comment: "케이크 맛있다")
        let reply4 = PostReplyData(profile: "emotionAdd", replier: "막내", comment: "웃으세요")
        postReplyList = [reply1,reply2,reply3,reply4]
        
    }
    
}



