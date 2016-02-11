//
//  ViewController.swift
//  WeiBo表情键盘
//
//  Created by 蒋进 on 16/2/10.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.将键盘控制器添加为当前控制器的子控制器
        addChildViewController(emoticonVC)
        
        // 2.将表情键盘控制器的view设置为UITextView的inputView
        customTextView.inputView = emoticonVC.view
        
        
        
    }
    
    // MARK: - 懒加载
    private lazy var emoticonVC: EmoticonViewController = EmoticonViewController()



}

