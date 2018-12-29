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
    class PostFullCell: UITableViewCell {
    }
    
    class PostReplyCell: UITableViewCell {
    }
    
    class PostNewReplyCell: UITableViewCell {
    }
    
    
    @IBOutlet var postFullTable: UITableView!
    
    var postProfileImage: UIImage?
    var postName: String?
    var postDate: String?
    var postImage: UIImage?
    var postImagePageControl: UIPageControl?
    var emotionImage: UIImage?
    var emotionName: String?
    var postContent: String?
    var replyCount: String?

    //댓글 보기 테이블
    
    
    //댓글 달기 테이블

    
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        postFullTable.delegate = self
        postFullTable.dataSource = self
        
        let cell = postFullTable.dequeueReusableCell(withIdentifier: "PostFullCell") as! PostFullCell
        
        cell.postProfileImageView.image = postProfileImage
        cell.postNameView.text = postName
        cell.postDateView.text = postDate
        cell.postImageView.image = postImage
        
        cell.emotionImageView.image = emotionImage
        cell.emotionNameView.text = emotionName
        
        cell.postContentView.text = postContent
        cell.replyCountView.text = replyCount
        
        // Do any additional setup after loading the view.
        
    }
    
    
}

extension PostFullVC: UITableViewDataSource {
    //게시글
    func tableView(_ tableView: postFullTable, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    //댓글보기
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    //댓글 달기
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        <#code#>
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}



extension PostFullVC: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        <#code#>
    }
}
