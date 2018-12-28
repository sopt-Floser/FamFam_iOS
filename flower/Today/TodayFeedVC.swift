//
//  TodayFeedVC.swift
//  flower
//
//  Created by 김지민 on 28/12/2018.
//  Copyright © 2018 성다연. All rights reserved.
//

import UIKit

class TodayFeedVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet var tableView:UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let postcell = tableView.dequeueReusableCell(withIdentifier: "todayPostCell", for: indexPath) as! todayPostCell
        // 상단 (프로필)
        postcell.postProfileImage.image = UIImage(named:"cakeImg")
        postcell.postName.text = ""
        postcell.postDate.text = ""
        // 중간 (게시글)
        postcell.postImage.image = UIImage(named:"cakeImg")
        postcell.postImagePagecontrol.currentPage = 0
        // 중간 (감정)
        postcell.emotionImage.image = UIImage(named: "cakeImg")
        postcell.emotionName.text = ""
        // 중간 (게시글)
        
        postcell.postContent.text = ""
        
        // 하단 (댓글)
        
        postcell.replyCount.text = ""
        
        
        return postcell
    }

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


