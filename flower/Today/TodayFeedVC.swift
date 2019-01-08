//
//  TodayFeedVC.swift
//  flower
//
//  Created by 김지민 on 28/12/2018.
//  Copyright © 2018 성다연. All rights reserved.
//

import UIKit

//var todayFeedList: [TodayFeedData] = []


class TodayFeedVC: UIViewController {
    
//    @IBOutlet var todayFeedTable: UITableView!
    @IBOutlet var todayFeedTable: UITableView!
    
    
    var todayFeedList = [Today_Contents]()
    var cellHeight : CGFloat = 0.0
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.endEditing(true)
//        getTodayFeedData() //모델에서 피드 데이터 받아오는 함수
        //cellForRowAt 에서 데이터 Set
        
        todayFeedTable.delegate = self
        todayFeedTable.dataSource = self

        self.todayFeedTable.rowHeight = UITableView.automaticDimension
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let index = todayFeedTable.indexPathForSelectedRow{
            todayFeedTable.deselectRow(at: index, animated: true)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hidesBottomBarWhenPushed = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hidesBottomBarWhenPushed = true
        TodayService.shared.getAllContent(page_no: 5, page_size: 5){[weak self] (data) in guard let `self` = self else {return}
            self.todayFeedList = data
            self.todayFeedTable.reloadData()
        }
    }
    
}
    


extension TodayFeedVC: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todayFeedList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /** string type의 optional을 풀어준다 */
        
        //cell 객체를 선언합니다. reusable identifier를 제대로 설정해주는거 잊지마세요!
        let cell = todayFeedTable.dequeueReusableCell(withIdentifier: "TodayFeedCell") as! TodayFeedCell
        //각 row에 해당하는 cell의 데이터를 넣어주기위해 모델에서 post 데이터 하나를 선언합니다.
        let post = todayFeedList[indexPath.row]
        
        
        cell.postName.text = String(post.content?.userIdx ?? 0)
        cell.postDate.text = post.content?.createDate
        cell.postImage?.imageFromUrl(gsno(post.photos), defaultImgPath: "")
        cell.postContent.text = post.content?.content
        cell.replyCount.text = String(post.content?.commentCount ?? 0)
 
        
        
//        /** string type의 optional을 풀어준다 */
//        func stringOptionalUnwork(_ value: String?) -> String{
//            guard let value_ = value else {
//                return ""
//            }
//            return value_
//        }
//
//        //cell 객체를 선언합니다. reusable identifier를 제대로 설정해주는거 잊지마세요!
//        let cell = todayFeedTable.dequeueReusableCell(withIdentifier: "TodayFeedCell") as! TodayFeedCell
//        //각 row에 해당하는 cell의 데이터를 넣어주기위해 모델에서 post 데이터 하나를 선언합니다.
//        let post = todayFeedList[indexPath.row]
//
//        //위에서 가져온 데이터를 각 cell에 넣어줍니다.
//
//
//        var checkimage = post.postProfileImage
//        cell.postProfileImage?.image = UIImage(named:stringOptionalUnwork(checkimage))
//
//        cell.postName.text = post.postName
//        cell.postDate.text = post.postDate
//        // 중간 (게시글)
//
//
//        checkimage = post.postImage
//        cell.postImage?.image = UIImage(named: stringOptionalUnwork(checkimage))
//
//        cell.postImagePagecontrol.numberOfPages = post.postImagePagecontrol
//        // 중간 (감정)
//
//        checkimage = post.emotionImage
//        cell.emotionImage?.image = UIImage(named: stringOptionalUnwork(checkimage))
//        cell.emotionName.text = post.emotionName
//        // 중간 (게시글)
//
//        cell.postContent.text = post.postContent
//
//        // 하단 (댓글)
//
//        cell.replyCount.text = String(post.replyCount)
//
//        //위의 과정을 마친 cell 객체를 반환합니다.
//
//        //showReply

//
        return cell
    }

    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
        //Get the height required for the TableView to show all cells
        
        
        //If cell's are more than 10 or so that it could not fit on the tableView's visible area then you have to go for other way to check for last cell loaded
        
    }

}

    


extension TodayFeedVC: UITableViewDelegate {
    //didSelectRowAt은 셀을 선택했을때 어떤 동작을 할지 설정해 줄 수 있습니다.
    /** 셀 선택 시 게시글 페이지로 전환 */
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //아래의 과정들은 화면전환에서 데이터 전달을 하는 방법과 동일합니다.
        
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "PostFullVC") as! PostFullVC
        let post = todayFeedList[indexPath.row]
        let row = tableView.cellForRow(at: indexPath)
        
        cellHeight = (row?.bounds.height)! //셀 높이 구하기
        
        nextVC.viewHeight = cellHeight //셀의 높이를 다음 화면의 뷰 높이로 보냄
        
        
        //nextVC.postProfileImage = post.postProfileImage
        nextVC.postName = String(post.content?.userIdx ?? 0)
        nextVC.postDate = post.content?.createDate
        // 중간 (게시글)
        nextVC.postImage?.imageFromUrl(gsno(post.content.photoName), defaultImgPath: "")
        nextVC.postImagePageControl = post.postImagePagecontrol
        // 중간 (감정)
        
        
        
        
        //nextVC.emotionImage = post.emotionImage
        //nextVC.emotionName = post.emotionName
        // 중간 (게시글)
        
        nextVC.postContent = post.content?.content
        
        // 하단 (댓글)
        
        nextVC.replyCount = post.content?.commentCount
        
//        present(nextVC, animated: true, completion: nil)
        navigationController?.pushViewController(nextVC, animated: true)
    } //여기까지 보셨다면 잠깐 다시 위의 viewWillApear로!
    
    
    
}

//extension TodayFeedVC {
//    func getTodayFeedData() {
//        let post1 = TodayFeedData(pPImage: "sampleProfile", pName: "승수", pDate: "19950801", pImage: "tempImg", pPage: 3, eImage: "emotionSmile", eName: "엄마", pContent: "스누피 뒷모습 너무 귀엽다 찰리브라운 대머리 스누피 귀가 잘 안보이네", rCount: 2)
//        let post2 = TodayFeedData(pPImage: "momPic", pName: "엄마", pDate: "20181225", pImage: "cakeImg", pPage: 5, eImage: "emotionSmile", eName: "막내", pContent: "엄마와 함께 즐거운 데이트! :) 날씨는 별로 엄마는 내 맘의 별로>< 배고프고 춥고 어쩌구 저쩌구! 엄청 많이 말하면 줄이 넘어가나 셀 사이즈 조정을 해야하는 데 그건 어떻게 해 망했어 진짜 어쩌구 저쩌구 길어졌나? 엄마와 함께 즐거운 데이트! :) 날씨는 별로 엄마는 내 맘의 별로>< 배고프고 춥고 어쩌구 저쩌구! 엄청 많이 말하면 줄이 넘어가나 셀 사이즈 조정을 해야하는 데 그건 어떻게 해 망했어 진짜 어쩌구 저쩌구 길어졌나? 엄마와 함께 즐거운 데이트! :) 날씨는 별로 엄마는 내 맘의 별로>< 배고프고 춥고 어쩌구 저쩌구! 엄청 많이 말하면 줄이 넘어가나 셀 사이즈 조정을 해야하는 데 그건 어떻게 해 망했어 진짜 어쩌구 저쩌구 길어졌나? 엄마와 함께 즐거운 데이트! :) 날씨는 별로 엄마는 내 맘의 별로>< 배고프고 춥고 어쩌구 저쩌구! 엄청 많이 말하면 줄이 넘어가나 셀 사이즈 조정을 해야하는 데 그건 어떻게 해 망했어 진짜 어쩌구 저쩌구 길어졌나? 엄마와 함께 즐거운 데이트! :) 날씨는 별로 엄마는 내 맘의 별로>< 배고프고 춥고 어쩌구 저쩌구! 엄청 많이 말하면 줄이 넘어가나 셀 사이즈 조정을 해야하는 데 그건 어떻게 해 망했어 진짜 어쩌구 저쩌구 길어졌나? 엄마와 함께 즐거운 데이트! :) 날씨는 별로 엄마는 내 맘의 별로>< 배고프고 춥고 어쩌구 저쩌구! 엄청 많이 말하면 줄이 넘어가나 셀 사이즈 조정을 해야하는 데 그건 어떻게 해 망했어 진짜 어쩌구 저쩌구 길어졌나? ", rCount: 4)
//        let post3 = TodayFeedData(pPImage: "tempImg", pName: "스누피", pDate: "20181225", pImage: "family", pPage: 5, eImage: "emotionSmile", eName: "막내", pContent: "가족", rCount: 10)
//        todayFeedList = [post1,post2,post3]
//
//    }
//
//}

