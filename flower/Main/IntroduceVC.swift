//
//  IntroduceVC.swift
//  flower
//
//  Created by 김지민 on 27/12/2018.
//  Copyright © 2018 성다연. All rights reserved.
//
import UIKit

class IntroduceVC: UIViewController {
    
    @IBOutlet var introduceImage: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    
    
    var images = ["imgIntro1","imgIntro2","imgIntro3","imgIntro4"] //소개 이미지들
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        introduceImage.image = UIImage(named: images[0])
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        pageControl.subviews.forEach {
            $0.transform = CGAffineTransform(scaleX: 1.7, y: 1.7)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        
        //페이지 컨트롤의 현재 페이지를 가져와서 uiimage타입의 이미지를 만들고 만든이미지를 뷰에 할당
        introduceImage.image = UIImage(named: images[pageControl.currentPage])
        
    }
    
    
}

