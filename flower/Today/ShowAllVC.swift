//
//  ShowAllVC.swift
//  flower
//
//  Created by 김지민 on 08/01/2019.
//  Copyright © 2019 성다연. All rights reserved.
//
import UIKit

class ShowAllVC: UIViewController {
    var PhotoList = [Today_Photo]()
    @IBOutlet var collectionView: UICollectionView!
    @IBAction func backBtn(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.delegate = self
        collectionView.dataSource = self
        print ("가나다1")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print ("가나다2")
        PhotoService.shared.getEntirePhotos(page_no: 0, page_size: 20){ jimin in
            guard let jimin2 = jimin.status else {return}
            guard let jimin3 = jimin.data else {return}
            guard let jimin4 = jimin3.photos else {return}
            switch jimin2{
            case 200 :
                self.PhotoList = jimin4
                self.collectionView.reloadData()
                print(self.PhotoList)
                print ("사진 조회 성공")
            case 204 :
                print ("사진을 찾을 수 없습니다.")
            case 404 :
                print ("회원을 찾을 수 없습니다.")
            case 500 :
                print ("서버 내부 에러")
            case 600 :
                print ("DB 에러")
            default :
                print("사진 전체보기 에러 코드 \(jimin2)")
                print ("모든 컨텐츠 조회")
            }
        }
    }
    
}

extension ShowAllVC: UICollectionViewDataSource {
    

//    internal func numberOfSectionsInTableView(tableView: UITableView) -> Int
//    {
//        return 2
//    }
//
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
//        if section == 0 {
//            return PhotoList.count
//        } else if section == 1 {    // this is going to be the last section with just 1 cell which will show the loading indicator
//            return 1
//        }
        return PhotoList.count

    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ShowAllCell", for: indexPath) as! ShowAllCell
        
        let post = PhotoList[indexPath.item]
        
        cell.imgView.imageFromUrl(gsno(post.photoName), defaultImgPath: "")
        print ("가나다5")
        return cell
    }
}

extension ShowAllVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width: CGFloat = (view.frame.width - 9) / 3
        let height: CGFloat = (view.frame.width - 9) / 3
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 4.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 4.5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    
    
}
