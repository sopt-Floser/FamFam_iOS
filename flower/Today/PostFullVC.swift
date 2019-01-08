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
        roundProfileImageView() // 프사 원형으로 보여주는 함수
        cropPostImage() //게시글 이미지 크롭하는 함수
        setPostReplyData()//댓글 데이터 받아오는 함수
        //게시글에 적용은 cellForRowAt 에서 set
        
        postFullTable.delegate = self
        postFullTable.dataSource = self
    
        self.postFullTable.allowsSelection = false; //선택 안되게 하기
//        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    //게시글
    @IBOutlet var postView: UIView!
    
    var viewHeight: CGFloat!
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
    func roundProfileImageView(){
        postProfileImageView?.clipsToBounds = true
        postProfileImageView?.layer.cornerRadius = (postProfileImageView.frame.height)/2
    }
    
    @IBOutlet var postNameView: UILabel!
    @IBOutlet var postDateView: UILabel!
    @IBOutlet var postImageView: UIImageView!
    func cropPostImage(){
        postImageView?.layer.masksToBounds = true
        postImageView?.clipsToBounds = true
    }
    @IBOutlet var postImagePageControlView: UIPageControl!
    @IBOutlet var emotionImageView: UIImageView!
    @IBOutlet var emotionNameView: UILabel!
    @IBOutlet var postContentView: UILabel!
    
    var textHeightConstraint: NSLayoutConstraint?
    
    func changeHeight() {
        self.textHeightConstraint = postContentView.heightAnchor.constraint(equalToConstant: 45)
        self.textHeightConstraint?.isActive = true
    }
    
    func adjustTextViewHeight() {
        let fixedWidth = postContentView.frame.size.width
        let newSize = postContentView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        self.textHeightConstraint?.constant = newSize.height
        self.view.layoutIfNeeded()
    }
    
    @IBOutlet var replyCountView: UILabel!
    
    func getsetPostData(){
        postView.bounds.size.height = viewHeight
        postProfileImageView.image = UIImage(named:postProfileImage!)
        postNameView.text = postName
        postDateView.text = postDate
        postImageView.image = UIImage(named:postImage!)
        postImagePageControlView.numberOfPages = postImagePageControl
        emotionImageView.image = UIImage(named:emotionImage!)
        emotionNameView.text = emotionName
        postContentView.text = postContent
        replyCountView.text = String(replyCount) + "개"
    }
    


    //댓글 보기
    
    
    //댓글 달기
    
    
    
    
    
    //
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

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = postFullTable.dequeueReusableCell(withIdentifier: "PostReplyCell", for: indexPath) as! PostReplyCell
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
    
    func stringOptionalUnwork(_ value: String?) -> String{
        guard let value_ = value else {
            return ""
        }
        return value_
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension PostFullVC {
    func setPostReplyData() {
        let reply1 = PostReplyData(profile: "sampleProfile", replier: "이승수", comment: "완전 추워")
        let reply2 = PostReplyData(profile: "cakeImg", replier: "케이크", comment: "한스 케잌 산딸기 무스 케이크 드세요 제발 드세요 진짜 맛있어요 드세요 드세요 어쩌구 저쩌구 케이크 케이크")
        let reply3 = PostReplyData(profile: "momPic", replier: "엄마아아아", comment: "케이크 맛있다아아아아아ㅏ아아아아아아ㅏ아아아아ㅏㅏ아아ㅏ아아아ㅏ아아아아아ㅏ아아아아아ㅏ아아ㅏㅏ아아아아아아ㅏ아아아아아ㅏ아아아아ㅏ아아아아ㅏ아아ㅏ아아아아ㅏ아아아ㅏ아")
        let reply4 = PostReplyData(profile: "emotionAdd", replier: "막내", comment: "웃으세요")
        let reply5 = PostReplyData(profile: "tempImg", replier: "스누피", comment: "스누피")
        let reply6 = PostReplyData(profile: "tempImg", replier: "스누피", comment: "스누피")
        let reply7 = PostReplyData(profile: "tempImg", replier: "스누피", comment: "스누피")
        let reply8 = PostReplyData(profile: "tempImg", replier: "스누피", comment: "스누피")
        let reply9 = PostReplyData(profile: "tempImg", replier: "스누피", comment: "스누피")
        let reply10 = PostReplyData(profile: "tempImg", replier: "스누피", comment: "스누피")
        postReplyList = [reply1,reply2,reply3,reply4,reply5,reply6,reply7,reply8,reply9,reply10]
    }
    
}



