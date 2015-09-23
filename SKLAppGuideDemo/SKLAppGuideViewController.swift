//
//  SKLAppGuideViewController.swift
//  引导页测试
//
//  Created by Tom on 15/9/22.
//  Copyright © 2015年 Tom. All rights reserved.
//

import UIKit


class SKLAppGuideViewController: UIViewController,UIScrollViewDelegate {

    
    //MARK: - 私有属性
    private let screenHeight = UIScreen.mainScreen().bounds.size.height
    private let screenWidth = UIScreen.mainScreen().bounds.size.width
    
    private let scrollView:UIScrollView = UIScrollView(frame: CGRectZero)
    private var pageControl:UIPageControl! = UIPageControl()
    
    
    private var nextVC:UIViewController! = nil
    
    private var arrGuideImages:[UIImageView]! = []
    
    //MARK: - 构造方法
    init(imagesForIPhone4:[UIImage],imagesForOther:[UIImage],nextViewController:UIViewController) {
        super.init(nibName: nil, bundle: nil)
        
        let arrImages:[UIImage] = screenHeight <= 480 ? imagesForIPhone4:imagesForOther
        arrGuideImages = (0..<arrImages.count).flatMap{UIImageView(image: arrImages[$0])}
        nextVC = nextViewController
    }


    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }

   //MARK: - 设置方法
    func setGuide(imagesForIPhone4:[UIImage],imagesForOther:[UIImage],nextViewController:UIViewController) {
        let arrImages:[UIImage] = screenHeight <= 480 ? imagesForIPhone4:imagesForOther
        arrGuideImages = (0..<arrImages.count).flatMap{UIImageView(image: arrImages[$0])}
        nextVC = nextViewController
    }
    
    
    //MARK:- 私有方法
    private func updateUI() {
        let numberOfPages = arrGuideImages.count
        
        //scrollView contentSize
        scrollView.frame = CGRectMake(0, 0, screenWidth, screenHeight)
        scrollView.contentSize = CGSizeMake(screenWidth * CGFloat(numberOfPages), screenHeight)
        scrollView.pagingEnabled = true
        scrollView.delegate = self
        view.addSubview(scrollView)
        
        
        //imageView
        for count in 0..<numberOfPages {
            arrGuideImages[count].frame = CGRectMake(CGFloat(count) * screenWidth, 0, screenWidth, screenHeight)
            scrollView.addSubview(arrGuideImages[count])
        }
        
        //pageControl
        pageControl.center = CGPointMake(screenWidth / 2, screenHeight * 0.9)
        pageControl.currentPage = 0
        pageControl.numberOfPages = numberOfPages
        pageControl.currentPageIndicatorTintColor = UIColor.blackColor()
        pageControl.pageIndicatorTintColor = UIColor.grayColor()
        view.addSubview(pageControl)
        
        //button
        let btnGo = UIButton(frame: CGRectMake(0, 0, 100, 30))
        btnGo.center = CGPointMake(CGFloat(numberOfPages - 1) * screenWidth + screenWidth / 2, screenHeight * 0.95)
        btnGo.setTitle("立刻体验", forState: .Normal)
        btnGo.layer.cornerRadius = 4
        btnGo.layer.masksToBounds = true
        btnGo.backgroundColor = UIColor.orangeColor()
        btnGo.tintColor = UIColor.whiteColor()
        btnGo.addTarget(self, action: "btnGoTap", forControlEvents: .TouchUpInside)
        scrollView.addSubview(btnGo)
        
    }
    
    
    func btnGoTap() {
        self.presentViewController(nextVC, animated: true, completion: nil)
    }
    
    //MARK: - scrollView delegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        pageControl.currentPage = Int((scrollView.contentOffset.x - screenWidth / 2) / screenWidth + 1)
        
    }
    
    //MARK: - 其它
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    
}
