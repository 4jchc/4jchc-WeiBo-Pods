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
        // 2.判断当前点击的是否是表情图片
        if emoticon.png != nil{
            // 1.创建附件
            let attachment = NSTextAttachment()
            attachment.image = UIImage(contentsOfFile: emoticon.imagePath!)
            // 设置了附件的大小
            attachment.bounds = CGRectMake(0, -4, 20, 20)
            
            // 2. 根据附件创建属性字符串
            let imageText = NSAttributedString(attachment: attachment)
            
            
            // 3.拿到当前所有的内容
            let strM = NSMutableAttributedString(attributedString: self.customTextView.attributedText)
            
            // 4.插入表情到当前光标所在的位置
            let range = self.customTextView.selectedRange
            strM.replaceCharactersInRange(range, withAttributedString: imageText)
            // 属性字符串有自己默认的尺寸
            strM.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(19), range: NSMakeRange(range.location, 1))
            
            // 5.将替换后的字符串赋值给UITextView
            self.customTextView.attributedText = strM
            // 恢复光标所在的位置
            // 两个参数: 第一个是指定光标所在的位置, 第二个参数是选中文本的个数
            self.customTextView.selectedRange = NSMakeRange(range.location + 1, 0)
            
        }
    }
    
    deinit
    {
        print("滚")
    }
    

}

