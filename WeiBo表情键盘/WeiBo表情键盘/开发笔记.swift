//
//  开发笔记.swift
//  WeiBo表情键盘
//
//  Created by 蒋进 on 16/2/10.
//  Copyright © 2016年 蒋进. All rights reserved.
//
import UIKit

//MARK: - 💗第一天
    /*
    //MARK:  1.界面布局
    1.控制器嵌套控制器要设置父子控制器
    addChildViewController
    2.设置UITextView的弹出自定义键盘
    customTextView.inputView = emoticonVC.view
    3.取消自动布局translates转化 Autoresizing自动调整尺寸 Mask屏蔽 Into变成,除 Constraints约束
    collectionVeiw.translatesAutoresizingMaskIntoConstraints = false
    4.添加约束数组 [NSLayoutConstraint]()
    view.addConstraints(cons)
    */

    /*
    //MARK:  2.完善键盘表情布局
    1.input输入 Accessory副的,辅助的 View
    2.设置内边距 里面的视图相对于主视图
    iconButton.frame = CGRectInset(contentView.bounds, 4, 4)
    3.主视图的内边距
    collectionView?.contentInset = UIEdgeInsets(top: y, left: 0, bottom: y, right: 0)
    */

    /*
    //MARK:  3 准备表情模型 扫描emoji表情
    1.获取微博表情的主路径
    (NSBundle.mainBundle().bundlePath as NSString).stringByAppendingPathComponent("Emoticons.bundle")
    2.stringByAppendingPathComponent拼接路径
    3.KVC的使用
    */

    /*
    //MARK:  4 显示表情
    1.emojy的大小就是字体的大小
    2.KVO的使用
    3.模型Didset的赋值
    */


    /*
    //MARK:  5 完善表情模型
    1.添加删除按钮和空白按钮
    2.遍历count-20添加标识
    3.分2中情况--够21,那第21标记为删除.如果不足要添加空白按钮和删除按钮
    */


    /*
    //MARK:  6 添加快速构造方法来设置标识init(isRemoveButton: Bool)
    1.表情分组跳转根据toobar的tag
    collectionVeiw.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: item.tag)
    */

    /*
    //MARK:  7 插入emoji表情
    1.监听cell的点击设置代理
    2.禁止按钮点击让父视图cell监听点击
    iconButton.userInteractionEnabled = false
    3.定义闭包在init方法中直接传值
    4.插入光标选中位置 self.customTextView.selectedTextRange
    replaceRange(self.customTextView.selectedTextRange!, withText: emoticon.emojiStr!)
    5.闭包强引用
     weak 相当于OC中的 __weak , 特点对象释放之后会将变量设置为nil
     unowned 相当于OC中的 unsafe_unretained, 特点对象释放之后不会将变量设置为nil
    */

    /*
    //MARK:  8 插入图片表情
    1. 创建附件NSText Attachment附属物
    let attachment = NSTextAttachment()
    设置了附件的大小
    attachment.bounds = CGRectMake(0, -4, 20, 20)
    2. 根据附件创建属性字符串
    let imageText = NSAttributedString(attachment: attachment)
    3. 拿到当前所有的内容
    let strM = NSMutableAttributedString(attributedString: self.customTextView.attributedText)
    4. 插入表情到当前光标所在的位置
    let range = self.customTextView.selectedRange
    strM.replaceCharactersInRange(range, withAttributedString: imageText)
    5. 将替换后的字符串赋值给UITextView
    self.customTextView.attributedText = strM
    6. 恢复光标所在的位置
     两个参数: 第一个是指定光标所在的位置, 第二个参数是选中文本的个数
    self.customTextView.selectedRange = NSMakeRange(range.location + 1, 0)
    */

    /*
    //MARK:  9 获取发送文本
    1.迭代遍历属性文本
     self.customTextView.attributedText.enumerate列举AttributesInRange
     遍历的时候传递给我们的objc是一个字典, 如果字典中的NSAttachment这个key有值
     那么就证明当前是一个图片
    2.自定义NSTextAttachment 设置属性-保存当时插入时的对应表情的文字
    */

    /*
    //MARK:  10 重构-删除按钮处理-最近表情添加
    1.deleteBackward
    2.排序对数组进行排序
    var result = emoticons?.sort({ (e1, e2) -> Bool in
    return e1.times > e2.times
    })
    */
//MARK: - 💗第二天

    /*
    表情键盘bug修复Font图片的大小
    1.字体的高度--font.lineHeight
    2.单例--表情只加载一次
    static let packageList:[EmoticonPackage] = EmoticonPackage.loadPackages()
    3.单例加载模型数组
    */









//MARK: - 开始💗

/*

class ViewController1: UIViewController {

    weak var customTextView: UITextView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.将键盘控制器添加为当前控制器的子控制器
        addChildViewController(emoticonVC)
        
        // 2.将表情键盘控制器的view设置为UITextView的inputView
        customTextView.inputView = emoticonVC.view
        // 初始化UI
        setupUI()
    }
    
    //MARK:  初始化UI
    ///  初始化UI
    private func setupUI(){
        
        // 1.添加子控件
        
        view.addSubview(<#collectionVeiw#>)
        view.addSubview(<#collectionVeiw#>)
        
        // 2.布局子控件
        
        <#setupConstraint()#>
    }
    //MARK:  纯代码设置约束
    func setupConstraint(){
        
        //使用Auto Layout的方式来布局
        button.translatesAutoresizingMaskIntoConstraints = false
        textField.translatesAutoresizingMaskIntoConstraints = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        
        // 创建一个约束数组
        var cons = [NSLayoutConstraint]()
        // 创建一个控件数组
        let dict = ["collectionVeiw": collectionVeiw, "toolbar": toolbar]
        
        //创建一个水平居中约束（按钮）
        cons += NSLayoutConstraint(
            item: button, attribute: .CenterX, relatedBy: .Equal,
            toItem: self.view, attribute: .CenterX, multiplier: 1.0, constant: 0.0)
        //创建水平方向约束
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[collectionVeiw]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
        cons += NSLayoutConstraint.constraintsWithVisualFormat("H:|-0-[toolbar]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
        //创建垂直方向约束
        cons += NSLayoutConstraint.constraintsWithVisualFormat("V:|-0-[collectionVeiw]-[toolbar(44)]-0-|", options: NSLayoutFormatOptions(rawValue: 0), metrics: nil, views: dict)
        
        view.addConstraints(cons)
        
        
    }
    
    
    // MARK: - 懒加载
    private lazy var emoticonVC = <#collectionVeiw#>()
    
    
}

*/

//MARK: - 结束💗





