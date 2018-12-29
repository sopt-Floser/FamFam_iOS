//
//  HomeCollectionVC.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 27..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit

class HomeCollectionVC: UIViewController {
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    let FamilyMember = ["엄마","아빠"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    }
}


extension HomeCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == mainCollectionView ){
            return 9
        } else {
            return FamilyMember.count
        }
    }
    
    /** 셀 바꾸어주기 */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 아래 큰 콜렉션 뷰
        if (collectionView == mainCollectionView) {
            var state = indexPath.row % 3
            
            switch state {
                case 0:
                    return firstCellSetting(mainCollectionView, indexPath: indexPath)
                case 1:
                    return secondCellSetting(mainCollectionView, indexPath: indexPath)
                case 2:
                    return thirdCellSetting(mainCollectionView, indexPath: indexPath)
                default:
                    return firstCellSetting(mainCollectionView, indexPath: indexPath)
            }
        }
        else {// 위의 큰 콜렉션 뷰 셀 세팅
              return familyCellSetting(profileCollectionView,indexPath:indexPath)
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
    
    /** 가족 프로필 cell 데이터 세팅 */
    func familyCellSetting(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "familyCell", for: indexPath) as! FamilyCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("select cell")
    }
    

    // 초점 가운데로 모이게 하기 ( 안됨)
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.mainCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWithIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing - 8
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWithIncludingSpacing
        let roundedIndex = round(index)
        
        offset = CGPoint(x: roundedIndex * cellWithIncludingSpacing - scrollView.contentInset.left, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}

