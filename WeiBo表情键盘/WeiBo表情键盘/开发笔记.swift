//
//  开发笔记.swift
//  WeiBo表情键盘
//
//  Created by 蒋进 on 16/2/10.
//  Copyright © 2016年 蒋进. All rights reserved.
//
import UIKit


    /*
    界面布局
    1.控制器嵌套控制器要设置父子控制器
    addChildViewController
    2.设置UITextView的弹出自定义键盘
     customTextView.inputView = emoticonVC.view
    3.取消自动布局translates转化 Autoresizing自动调整尺寸 Mask屏蔽 Into变成,除 Constraints约束
    collectionVeiw.translatesAutoresizingMaskIntoConstraints = false
    4.添加约束数组 [NSLayoutConstraint]()
    view.addConstraints(cons)
    */





class ViewController1: UIViewController {
    
   weak var customTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.将键盘控制器添加为当前控制器的子控制器
        addChildViewController(emoticonVC)
        
        // 2.将表情键盘控制器的view设置为UITextView的inputView
        customTextView.inputView = emoticonVC.view
        
    }
    
    //MARK: - 初始化UI
    ///  初始化UI
    private func setupUI(){
        
        // 1.添加子控件
        
        view.addSubview(<#collectionVeiw#>)
        view.addSubview(<#collectionVeiw#>)
        
        // 2.布局子控件
        
        
    }
    
    // MARK: - 懒加载
    private lazy var emoticonVC = <#collectionVeiw#>()


}
