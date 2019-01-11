//
//  FullPostVC.swifttodayReplyCelltodayNewReplyCell
//  flower
//
//  Created by 김지민 on 28/12/2018.
//  Copyright © 2018 성다연. All rights reserved.
//

import UIKit

class PostFullVC: UIViewController, UIScrollViewDelegate {
   
    @IBOutlet var postFullTable: UITableView!
///게시글

    var viewHeight: CGFloat!
    var postProfileImage: String?
    var postName: String?
    var postDate: String?
    var postImagePageControl: Int!
    var emotionImage: String?
    var emotionName: String?
    var postContent: String?
    var replyCount: Int!
    var images = [String]()
    var contentIdx: Int!
    
    @IBAction func backBtn(_ sender: Any) {
        dismiss(animated: true, completion: nil)
       //navigationController?.popViewController(animated: true)
    }
    
    @IBOutlet var postView: UIView!
    @IBOutlet var postProfileImageView: UIImageView!
    func roundProfileImageView(){
        postProfileImageView?.clipsToBounds = true
        postProfileImageView?.layer.cornerRadius = (postProfileImageView.frame.height)/2
    }
    @IBOutlet var postNameView: UILabel!
    @IBOutlet var postDateView: UILabel!
    func cropPostImage(){
        //        postImageView?.layer.masksToBounds = true
        //        postImageView?.clipsToBounds = true
    }
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var postImagePageControlView: UIPageControl!
    @IBOutlet var emotionImageView: UIImageView!
    @IBOutlet var emotionNameView: UILabel!
    @IBOutlet var postContentView: UILabel!
    
///댓글 보기
    var postReplyList = [TodayComment]()
    
    
///댓글 달기

    @IBOutlet var replyTextView: UITextView!
    @IBOutlet var writeReply: UITextField!
    @IBAction func completeReply(_ sender: Any) {
        guard writeReply.text?.isEmpty != true else {return}
        guard let content = writeReply.text else {return}
        // 작성된 api를 사용하여 게시글을 작성하고 만약 완료되었다면
        CommentService.shared.writeComment(contentIdx: contentIdx, content: content){ jimin in
            guard let status = jimin.status else {return}
            switch status {
            case 201 :
                self.simpleAlert("댓글 작성", "댓글이 작성되었습니다.", completion: { (action) in
                   self.navigationController?.popViewController(animated: true)
                })
                self.postFullTable.reloadData()
                print("댓글 등록 성공")
            case 404 :
                print("게시글을 찾을 수 없습니다")
            case 500 :
                print("서버 내부 에러")
            case 600 :
                print("db 에러")
            default :
                print(status)
                print("댓글 등록 디폴트")
            }
        }
    }
    
    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        getsetPostData() //게시글 데이터 앞 페이지에서 받아오고 세팅하는 함수
        roundProfileImageView() // 프사 원형으로 보여주는 함수
        //cropPostImage() //게시글 이미지 크롭하는 함수
        //게시글에 적용은 cellForRowAt 에서 set
        
        postFullTable.delegate = self
        postFullTable.dataSource = self
        
        self.postFullTable.allowsSelection = false; //선택 안되게 하기
        
        postImagePageControlView.currentPage = 0
        
        print("이미지 리스트 : >> \(images)")
        print("댓글 리스트 : \(postReplyList)")
        imageScroll()
        self.postFullTable.reloadData()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboard(notification:)), name:UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        setupTap()
    }
    
    @objc func keyboard(notification:Notification) {
        guard let keyboardReact = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else{
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification ||  notification.name == UIResponder.keyboardWillChangeFrameNotification {
            self.view.frame.origin.y = -keyboardReact.height
        }else{
            self.view.frame.origin.y = 0
        }
        
    }
    
    func setupTap() {
        let viewTap = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.view.addGestureRecognizer(viewTap)
    }
    
    @objc func viewTapped() {
        self.view.endEditing(true)
    }
    
    
    func imageScroll(){
        view.layoutIfNeeded()
        scrollView.delegate = self
        for i in 0..<images.count {
            let xOrigin = self.scrollView.frame.width * CGFloat(i)
            let imageView = UIImageView(frame: CGRect(x: xOrigin, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height))
            imageView.isUserInteractionEnabled = true
            imageView.imageFromUrl(images[i], defaultImgPath: "")
            imageView.contentMode = .scaleAspectFill
            self.scrollView.addSubview(imageView)
        }
        
        self.scrollView.isPagingEnabled = true
        self.scrollView.bounces = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.contentSize = CGSize(width:
            self.scrollView.frame.width * CGFloat(images.count), height: self.scrollView.frame.height)
        postImagePageControlView.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
        
        self.postImagePageControlView.numberOfPages = images.count
        self.postImagePageControlView.currentPage = 0
        self.postImagePageControlView.tintColor = UIColor.red
        self.postImagePageControlView.pageIndicatorTintColor = UIColor.black
        self.postImagePageControlView.currentPageIndicatorTintColor = UIColor.blue
    }
    
    @objc func changePage(sender: AnyObject) {
        let x = CGFloat(postImagePageControlView.currentPage) * scrollView.frame.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageNumber = floor(scrollView.contentOffset.x / scrollView.frame.width)
        postImagePageControlView.currentPage = Int(pageNumber)
    }
    
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
        postProfileImageView.imageFromUrl(postProfileImage, defaultImgPath: "")
        postNameView.text = postName
        postDateView.text = postDate
        postImagePageControlView.numberOfPages = postImagePageControl
        postContentView.text = postContent
        replyCountView.text = String(replyCount ?? 0) + "개"
    }
    
//댓글 보기
    
    override func viewWillAppear(_ animated: Bool) {
        print("댓글 보기 전")
        super.viewWillAppear(animated)
        CommentService.shared.getComment(contentIdx: contentIdx) {data in
            guard let status = data.status else {return}
            guard let reply = data.data else {return}
            switch status{
            case 200 :
                self.postReplyList = reply
                self.postFullTable.reloadData()
                print ("댓글 조회 성공")
            case 204 :
                print ("댓글을 찾을 수 없습니다.")
            case 500 :
                print ("서버 내부 에러")
            case 600 :
                print ("DB 에러")
            default :
                print(status)
                print ("댓글 조회 default")
            }
        }
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
            print("postReplyList: \(postReplyList)")
            return postReplyList.count
        default :
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = postFullTable.dequeueReusableCell(withIdentifier: "PostReplyCell") as! PostReplyCell
        print("리스트\(postReplyList)")
        //각 row에 해당하는 cell의 데이터를 넣어주기위해 모델에서 reply 데이터 하나를 선언합니다.
        let reply = postReplyList[indexPath.row]
        //위에서 가져온 데이터를 각 cell에 넣어줍니다.
        cell.replyImage.imageFromUrl(gsno(reply.userProfile), defaultImgPath: "")
        cell.replyName.text = reply.userName
        cell.replyContent.text = reply.content
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

