//
//  HomeCollectionVC.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 27..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit

class HomeCollectionVC: UIViewController {
    /** 콜렉션 뷰 */
    @IBOutlet weak var mainCollectionView: UICollectionView!
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    var FamilyMember:[FamilyModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tempDataBase()
        collectionViewDD()
        scrollToNextItem()
        scrollToPreviousItem()
    }
    
    func tempDataBase(){
        var family = FamilyModel(image: "momPic", name: "엄마")
        var family2 = FamilyModel(image: "cakeImg", name: "아빠")
        var family3 = FamilyModel(image: "sampleProfile", name: "이승수")
        FamilyMember = [family, family2, family3, family, family2]
    }
    
    func collectionViewDD(){
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        
        mainCollectionView.delegate = self
        mainCollectionView.dataSource = self
    }
}

extension HomeCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource , UIScrollViewDelegate{
    func scrollToNextItem() {
        let contentOffset = CGFloat(floor(profileCollectionView.contentOffset.x + profileCollectionView.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func scrollToPreviousItem() {
        let contentOffset = CGFloat(floor(profileCollectionView.contentOffset.x - profileCollectionView.bounds.size.width))
        self.moveToFrame(contentOffset: contentOffset)
    }
    
    func moveToFrame(contentOffset : CGFloat) {
        let frame: CGRect = CGRect(x: contentOffset, y: profileCollectionView.contentOffset.y , width: profileCollectionView.frame.width, height: profileCollectionView.frame.height)
        profileCollectionView.scrollRectToVisible(frame, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (collectionView == mainCollectionView ){
            return 9
        } else {
            return FamilyMember.count
        }
    }
    
    /** 셀 바꾸어주기 */
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        mainCollectionView.layoutSubviews()
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
            super.viewDidLayoutSubviews()
            let layout = UICollectionViewFlowLayout()
            var collectionHeight = view.frame.height
            var collectionWidth = view.frame.width
            //layout.headerReferenceSize = CGSize(width: 0, height: 0)
            
            layout.scrollDirection = .horizontal
            if FamilyMember.count > 5 {
                layout.minimumLineSpacing = 15
                layout.minimumInteritemSpacing = 15
            }
            else {
                layout.minimumLineSpacing = 30
                layout.minimumInteritemSpacing = 30

            }
            collectionView.collectionViewLayout = layout
            
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
        // NoticeCel에서 데이터 연결 완료
        return cell
    }
    
    /** 가족 프로필 cell 데이터 세팅 */
    func familyCellSetting(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "familyCell", for: indexPath) as! FamilyCell
        
        cell.familyImage.image = FamilyMember[indexPath.row].familyImage
        cell.familyName.text = FamilyMember[indexPath.row].familyName
        cell.frame = CGRect(x: cell.frame.origin.x, y: 0, width: 45, height: 69)
        return cell
    }

    /** 셀 가운데 있는거 크게 보여주기 */
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if collectionView == mainCollectionView {
            let size = CGSize(width: collectionView.bounds.width, height: collectionView.bounds.height)
            let point = CGPoint(x: size.width/2.0, y: size.height/2.0 )
            let centerIndex = collectionView.indexPathForItem(at: point) as! Int
            print("homeCellPoint = \(point)")
            print("centerIndex = \(centerIndex)")
            if indexPath.item == centerIndex {
                return CGSize(width: 320, height: view.frame.height+10)
            }
            return CGSize(width: 311, height: view.frame.height)
        }
        return CGSize(width: 45, height: 69)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == profileCollectionView){
            // 개인 사진첩 이동 코드 작성
            print("select family profile")
        }
    }
    
    // 초점 가운데로 모이게 하기
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let layout = self.mainCollectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        let cellWithIncludingSpacing = layout.itemSize.width + layout.minimumLineSpacing
        
        var offset = targetContentOffset.pointee
        let index = (offset.x + scrollView.contentInset.left) / cellWithIncludingSpacing
        let roundedIndex = round(index)
    
        let settingFocus = (self.view.frame.width - layout.itemSize.width ) / 2

        offset = CGPoint(x: roundedIndex * cellWithIncludingSpacing - scrollView.contentInset.left - settingFocus, y: -scrollView.contentInset.top)
        targetContentOffset.pointee = offset
    }
}



extension HomeCollectionVC : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @IBAction func cameraBtn(_ sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        
        /** 카메라를 사용해서 이미지를 선택하겠다는 옵션을 추가함 */
        let actionSheet = UIAlertController(title: "Photo source", message: "Choose a source", preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "Camera", style: .default, handler: { (action) in
            if UIImagePickerController.isSourceTypeAvailable(.camera) {
                picker.sourceType = .camera
                picker.allowsEditing = true
                picker.showsCameraControls = true
                self.present(picker, animated: true)
            } else {
                print("not available")
            }
        }))
        
        /** 아이폰 내의 이미지를 사용하겠다는 옵션 추가 */
        actionSheet.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: { (action) in
            picker.sourceType = .photoLibrary
            picker.allowsEditing = true
            self.present(picker, animated: true)
        }))
        actionSheet.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        self.present(actionSheet, animated: true)
        
    }
    
    //이미지를 선택하지 않고 피커 종료시에 실행되는 delegate 메소드
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    //이미지 피커에서 이미지를 선택하였을 때 일어나는 이벤트를 작성하는 메소드
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImg = UIImage()
        
        if let possibleImg = info[.editedImage] as? UIImage {
            newImg = possibleImg
        }
        else if let possibleImg = info[.originalImage] as? UIImage {
            newImg = possibleImg
        }
        else {
            return
        }
    
//        back = newImg
        dismiss(animated: true, completion: nil)
    }
}
