//
//  todayBoardCell.swift
//  flower
//
//  Created by 성다연 on 2018. 12. 27..
//  Copyright © 2018년 성다연. All rights reserved.
//

import UIKit
import Foundation



class TodayFeedCell: UITableViewCell, UIScrollViewDelegate{
    
    var imageList = [String]()

    override func awakeFromNib() {
        super.awakeFromNib()
        
        roundProfileImage() //프로필 이미지 둥글게
        cropPostImage() //게시글 이미지 위아래 커트
        //이미지 페이지 컨트로
        swipeImage()
        
    }
    
    // 상단 (프로필)
    @IBOutlet var postProfileImage: UIImageView!
    func roundProfileImage(){
        postProfileImage?.clipsToBounds = true
        postProfileImage?.layer.cornerRadius = (postProfileImage?.frame.height)!/2
    }
    
    @IBOutlet var postName: UILabel!
    @IBOutlet var postDate: UILabel!
    
    // 중간 (게시글)
    @IBOutlet var postImage: UIImageView!
    
    func cropPostImage(){
        
        scrollView?.layer.masksToBounds = true
        scrollView?.clipsToBounds = true
    }
    @IBOutlet var scrollView: UIScrollView!
    
    func swipeImage() {
        //view.layoutIfNeeded()
        scrollView.delegate = self
        for i in 0..<imageList.count {
            let xOrigin = self.scrollView.frame.width * CGFloat(i)
            let imageView = UIImageView(frame: CGRect(x: xOrigin, y: 0, width: self.scrollView.frame.width, height: self.scrollView.frame.height))
            imageView.isUserInteractionEnabled = true
            let imgStr = imageList[i]
            imageView.image = UIImage(named: imgStr)
            imageView.contentMode = .scaleAspectFit
            self.scrollView.addSubview(imageView)
        }
        self.scrollView.isPagingEnabled = true
        self.scrollView.bounces = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.contentSize = CGSize(width:
            self.scrollView.frame.width * CGFloat(imageList.count), height: self.scrollView.frame.height)
        pageControl.addTarget(self, action: #selector(self.changePage(sender:)), for: UIControl.Event.valueChanged)
        
        self.pageControl.numberOfPages = imageList.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.black
        self.pageControl.currentPageIndicatorTintColor = UIColor.blue
    }
    
    
    @objc func changePage(sender: AnyObject) {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.width
        scrollView.setContentOffset(CGPoint(x: x, y: 0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = floor(scrollView.contentOffset.x / scrollView.frame.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    
    
    
    
    
    
    
    
    
    
    
    @IBOutlet var pageControl: UIPageControl!

    // 중간 (감정)
    @IBAction func emotionAddBtn(_ sender: Any) {
    }
    @IBOutlet var emotionImage: UIImageView?
    @IBOutlet var emotionName: UILabel!
    

    //중간 (게시글)
    @IBOutlet weak var postContent: UILabel!
    
    //하단 (댓글)
    
  
   
    
    @IBOutlet weak var replyCount: UILabel!

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
