//
//  ViewController.swift
//  WeiBo表情键盘
//
//  Created by 蒋进 on 16/2/10.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBAction func itemClick(sender: AnyObject) {
        
        var strM = String()
        // 后去需要发送给服务器的数据
        self.customTextView.attributedText.enumerateAttributesInRange( NSMakeRange(0, self.customTextView.attributedText.length), options: NSAttributedStringEnumerationOptions(rawValue: 0)) { (objc, range, _) -> Void in
            /*
            // 遍历的时候传递给我们的objc是一个字典, 如果字典中的NSAttachment这个key有值
            // 那么就证明当前是一个图片
            print(objc["NSAttachment"])
            // range就是纯字符串的范围
            // 如果纯字符串中间有图片表情, 那么range就会传递多次
            print(range)
            let res = (self.customTextView.text as NSString).substringWithRange(range)
            print(res)
            print("++++++++++++++++++++++++++")
            */
            
            
            if objc["NSAttachment"] != nil
            {
                let attachment =  objc["NSAttachment"] as! EmoticonTextAttachment
                // 图片
                //                strM += "[图片]"
                strM += attachment.chs!
            }else
            {
                // 文字
                strM += (self.customTextView.text as NSString).substringWithRange(range)
            }
            
            
        }
        print("strM = \(strM)")
        
    }
    
    

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
            //let attachment = NSTextAttachment()
            let attachment = EmoticonTextAttachment()
            attachment.chs = emoticon.chs
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

