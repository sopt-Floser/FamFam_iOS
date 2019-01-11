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
    
    @IBOutlet var todayFeedTable: UITableView!
    
    var images = [String]()
    var todayFeedList = [Today_Contents]()
    var cellHeight : CGFloat = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.endEditing(true)
   
        todayFeedTable.delegate = self
        todayFeedTable.dataSource = self
        self.todayFeedTable.reloadData()

        self.todayFeedTable.rowHeight = UITableView.automaticDimension
        view.layoutIfNeeded()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        if let index = todayFeedTable.indexPathForSelectedRow{
            todayFeedTable.deselectRow(at: index, animated: true)
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.hidesBottomBarWhenPushed = false
        
        TodayService.shared.getAllContent(page_no: 0, page_size: 10){ jimin in
            guard let jimin2 = jimin.status else {return}
            guard let jimin3 = jimin.data else {return}
            guard let jimin4 = jimin3.contents else {return}
            switch jimin2{
            case 200 :
                self.todayFeedList = jimin4
                self.todayFeedTable.reloadData()
                print ("오늘의 하루 피드 조회 성공")
            case 204 :
                print ("게시글을 찾을 수 없습니다.")
            case 404 :
                print ("회원을 찾을 수 없습니다.")
            case 500 :
                print ("서버 내부 에러")
            case 600 :
                print ("DB 에러")
            default :
                print(jimin2)
                print ("모든 컨텐츠 조회")
                
            }
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodayFeedCell") as! TodayFeedCell
        print("리스트\(todayFeedList)")
        //각 row에 해당하는 cell의 데이터를 넣어주기위해 모델에서 post 데이터 하나를 선언합니다.
        let post = todayFeedList[indexPath.row]
        
        cell.postProfileImage?.imageFromUrl(gsno(post.userProfile), defaultImgPath: "")
        cell.postName.text = post.userName
        cell.postDate.text = post.content?.createdAt
        cell.postImage.imageFromUrl(gsno(post.photos?[0].photoName), defaultImgPath: "")
        
        cell.pageControl.numberOfPages = post.photos!.count
        
        cell.postContent.text = post.content?.content
        cell.replyCount.text = String(post.content?.commentCount ?? 0) + "개"
        //pagecontrol, emotion image, emotion name
        

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
        
        nextVC.postProfileImage = gsno(post.photos?[0].photoName)
        nextVC.postName = post.userName
        nextVC.postDate = post.content?.createdAt
        for i in 0..<post.photos!.count {
            nextVC.images.append(gsno(post.photos?[i].photoName))
        }
        nextVC.postImagePageControl = post.photos?.count
        nextVC.postContent = post.content?.content
        nextVC.replyCount = post.content?.commentCount
        nextVC.contentIdx = post.content?.contentIdx

        self.hidesBottomBarWhenPushed = true
        
        print ("게시글 상세보기 페이지로 넘어갑니다")

        present(nextVC, animated: true, completion: nil)
        //navigationController?.pushViewController(nextVC, animated: true)
    }
}


