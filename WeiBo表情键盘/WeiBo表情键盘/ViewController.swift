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
    // weak 相当于OC中的 __weak , 特点对象释放之后会将变量设置为nil
    // unowned 相当于OC中的 unsafe_unretained, 特点对象释放之后不会将变量设置为nil
    private lazy var emoticonVC: EmoticonViewController = EmoticonViewController { [unowned self] (emoticon) -> () in
        
        // 1.判断当前点击的是否是emoji表情
        if emoticon.emojiStr != nil{
            self.customTextView.replaceRange(self.customTextView.selectedTextRange!, withText: emoticon.emojiStr!)
        }
    }
    
    deinit
    {
        print("滚")
    }
    

}

