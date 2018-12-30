//
//  TodayFeedVC.swift
//  flower
//
//  Created by 김지민 on 28/12/2018.
//  Copyright © 2018 성다연. All rights reserved.
//

import UIKit

class TodayFeedVC: UIViewController {
    
    @IBOutlet var todayFeedTable: UITableView!
    
    var todayFeedList: [TodayFeedData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTodayFeedData()
        
        todayFeedTable.delegate = self
        todayFeedTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let index = todayFeedTable.indexPathForSelectedRow{
            todayFeedTable.deselectRow(at: index, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.isUserInteractionEnabled = false
    }
 

}

extension TodayFeedVC: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayFeedList.count
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
        let cell = todayFeedTable.dequeueReusableCell(withIdentifier: "TodayFeedCell") as! TodayFeedCell
        //각 row에 해당하는 cell의 데이터를 넣어주기위해 모델에서 post 데이터 하나를 선언합니다.
        let post = todayFeedList[indexPath.row]
        
        //위에서 가져온 데이터를 각 cell에 넣어줍니다.
        
        
        var checkimage = post.postProfileImage
        cell.postProfileImage?.image = UIImage(named:stringOptionalUnwork(checkimage))
        
        cell.postName.text = post.postName
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
    //didSelectRowAt은 셀을 선택했을때 어떤 동작을 할지 설정해 줄 수 있습니다.
    /** 셀 선택 시 게시글 페이지로 전환 */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //아래의 과정들은 화면전환에서 데이터 전달을 하는 방법과 동일합니다.
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "PostFull") as! PostFullVC
        let post = todayFeedList[indexPath.row]
        
       
        nextVC.postProfileImage = UIImage(named: post.postProfileImage!)
        nextVC.postName = post.postName
        nextVC.postDate = post.postDate
        // 중간 (게시글)
        nextVC.postImage = UIImage(named: post.postImage!)
        nextVC.postImagePageControl!.currentPage = post.postImagePagecontrol
        // 중간 (감정)
        
        nextVC.emotionImage = UIImage(named: post.emotionImage!)
        nextVC.emotionName = post.emotionName
        // 중간 (게시글)
        
        nextVC.postContent = post.postContent
        
        // 하단 (댓글)
        
        nextVC.replyCount = String(post.replyCount)
        navigationController?.pushViewController(nextVC, animated: true)
    } //여기까지 보셨다면 잠깐 다시 위의 viewWillApear로!
    
    //canMoveRowAt은 테이블뷰의 row의 위치를 이동할 수 있는지 없는지 설정합니다.
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
}


extension TodayFeedVC {
    func setTodayFeedData() {
        let post1 = TodayFeedData(pPImage: "sampleProfile", pName: "승수", pDate: "19950801", pImage: "family", pPage: 3, eImage: "emotionSmile", eName: "딸", pContent: "졸리다", rCount: 3)
        let post2 = TodayFeedData(pPImage: "cakeImg", pName: "딸", pDate: "20181225", pImage: "cakeImg", pPage: 5, eImage: "cakeImg", eName: "막내", pContent: "배고프다", rCount: 5)
        todayFeedList = [post1,post2]
        
    }
    
}



