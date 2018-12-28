//
//  HomeCollectionVC.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 27..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit

class HomeCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
   
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    
    var items = ["1","2","3"]
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return items.count
    }
    
    /** 셀 바꾸어주기 */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
            case 0:
                return firstCellSetting(mainCollectionView, indexPath: indexPath)
            case 1:
                return secondCellSetting(mainCollectionView, indexPath: indexPath)
            case 2:
                return thirdCellSetting(mainCollectionView, indexPath: indexPath)
        default:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statisticCell", for: indexPath) as! StatisticCell
            return cell
        }
    }
    
    /** 통계 cell 데이터 세팅 */
    func firstCellSetting(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "statisticCell", for: indexPath) as! StatisticCell
        return cell
    }
    
    /** 일주일 cell 데이터 세팅 */
    func secondCellSetting(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weekCalendarCell", for: indexPath)
        return cell
    }
    
    /** 알림 cell 데이터 세팅 */
    func thirdCellSetting(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "noticeCell", for: indexPath) as! NoticeCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select cell")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}
