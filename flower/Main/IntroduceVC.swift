//
//  IntroduceVC.swift
//  flower
//
//  Created by 김지민 on 27/12/2018.
//  Copyright © 2018 성다연. All rights reserved.
//
import UIKit


class IntroduceVC: UIViewController, UIScrollViewDelegate {
    
    @IBOutlet var pageControl: UIPageControl!
    
    @IBOutlet var scrollView: UIScrollView!
    
    
    var imageList = ["imgIntro1","imgIntro2","imgIntro3","imgIntro4"] //소개 이미지들
    
    override func viewDidLoad() {
        view.layoutIfNeeded()
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

    
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        pageControl.numberOfPages = images.count
//        pageControl.currentPage = 0
//        introduceImage.image = UIImage(named: images[0])
//
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func viewDidLayoutSubviews() {
//        pageControl.subviews.forEach {
//            $0.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
//        }
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//
//    @IBAction func pageChanged(_ sender: UIPageControl) {
//
//        //페이지 컨트롤의 현재 페이지를 가져와서 uiimage타입의 이미지를 만들고 만든이미지를 뷰에 할당
//        introduceImage.image = UIImage(named: images[pageControl.currentPage])
//
//    }
    
    
}

