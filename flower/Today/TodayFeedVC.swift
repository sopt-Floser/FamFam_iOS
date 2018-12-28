//
//  TodayFeedVC.swift
//  flower
//
//  Created by 김지민 on 28/12/2018.
//  Copyright © 2018 성다연. All rights reserved.
//

import UIKit

class TodayFeedVC: UIViewController {
    
    @IBOutlet var todayPostTable: UITableView!
    
    var todayPostList: [TodayPostData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("view Load!")
        setTodayPostData()
        
        todayPostTable.delegate = self
        todayPostTable.dataSource = self
        

        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let index = todayPostTable.indexPathForSelectedRow{
            todayPostTable.deselectRow(at: index, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.isUserInteractionEnabled = false
    }
 

}

extension TodayFeedVC: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayPostList.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 527
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        /** string type의 optional을 풀어준다 */
        func stringOptionalUnwork(_ value: String?) -> String{
            guard let value_ = value else {
                return ""
            }
            return value_
        }
        
        //cell 객체를 선언합니다. reusable identifier를 제대로 설정해주는거 잊지마세요!
        let cell = todayPostTable.dequeueReusableCell(withIdentifier: "todayPostCell") as! todayPostCell
        //각 row에 해당하는 cell의 데이터를 넣어주기위해 모델에서 post 데이터 하나를 선언합니다.
        let post = todayPostList[indexPath.row]
        
        //위에서 가져온 데이터를 각 cell에 넣어줍니다.
        
        var checkimage = post.postProfileImage
        cell.postProfileImage?.image = UIImage(named:stringOptionalUnwork(checkimage))
    
       
        cell.postDate.text = post.postDate
        // 중간 (게시글)
        
        
        checkimage = post.postImage
        cell.postImage?.image = UIImage(named: stringOptionalUnwork(checkimage))
       
        cell.postImagePagecontrol.currentPage = post.postImagePagecontrol

        // 중간 (감정)
            
        checkimage = post.emotionImage
        cell.emotionImage?.image = UIImage(named: stringOptionalUnwork(checkimage))
        
       
        cell.emotionName.text = post.emotionName
        // 중간 (게시글)
        
        cell.postContent.text = post.postContent
        
        // 하단 (댓글)
        
        cell.replyCount.text = String(post.replyCount)
        
        //위의 과정을 마친 cell 객체를 반환합니다.
        return cell
    }
    
    
}


extension TodayFeedVC: UITableViewDelegate {
    
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      
    }

}

extension TodayFeedVC {
    func setTodayPostData() {
        let post1 = TodayPostData(pPImage: "cakeImg", pName: "엄마", pDate: "19950801", pImage: "family", pPage: 3, eImage: "cakeImg", eName: "딸", pContent: "졸리다", rCount: 3)
        let post2 = TodayPostData(pPImage: "cakeImg", pName: "딸", pDate: "20181225", pImage: "cakeImg", pPage: 5, eImage: "cakeImg", eName: "막내", pContent: "배고프다", rCount: 5)
        todayPostList = [post1,post2]
        
    }
    
    
}



