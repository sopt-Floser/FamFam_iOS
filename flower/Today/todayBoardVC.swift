//
//  todayBoardVC.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 27..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit

class todayBoardVC: UITableViewController {

    /** 서버와 연결안되어있음
     1. 임시 데이터 적용
     2. 열 개수 데이터 개수만큼
     */
    
    /** 서버에서 데이터 받아오기  */
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let boardcell = tableView.dequeueReusableCell(withIdentifier: "today_board_Cell", for: indexPath) as! todayBoardCell
        // 상단 (프로필)
        boardcell.profileImage.image = UIImage(named:"cakeImg")
        boardcell.profileName.text = ""
        boardcell.profileDate.text = ""
        // 중간 (게시글)
        boardcell.boardContent.image = UIImage(named:"cakeImg")
        boardcell.boardPagecontrol.currentPage = 0
        // 하단 (댓글)
        boardcell.commentImage.image = UIImage(named:"cakeImg")
        boardcell.commentName.text = ""
        boardcell.commentContent.text = ""
        boardcell.commentCount.text = ""

    
        return boardcell
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}