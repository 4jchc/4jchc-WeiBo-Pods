//
//  开发笔记.swift
//  WeiBo表情键盘
//
//  Created by 蒋进 on 16/2/10.
//  Copyright © 2016年 蒋进. All rights reserved.
//
import UIKit


    /*
    //MARK: - 1.界面布局
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
    //MARK: - 2.完善键盘表情布局
    1.input输入 Accessory副的,辅助的 View
    2.设置内边距 里面的视图相对于主视图
    iconButton.frame = CGRectInset(contentView.bounds, 4, 4)
    3.主视图的内边距
    collectionView?.contentInset = UIEdgeInsets(top: y, left: 0, bottom: y, right: 0)
    */

    /*
    //MARK: - 3 准备表情模型 扫描emoji表情
    1.获取微博表情的主路径
    (NSBundle.mainBundle().bundlePath as NSString).stringByAppendingPathComponent("Emoticons.bundle")
    2.stringByAppendingPathComponent拼接路径
    3.KVC的使用
    */

    /*
    //MARK: - 4 显示表情
    1.emojy的大小就是字体的大小
    2.KVO的使用
    3.模型Didset的赋值
    */


    /*
    //MARK: - 5 完善表情模型
    1.添加删除按钮和空白按钮
    2.遍历count-20添加标识
    3.分2中情况--够21,那第21标记为删除.如果不足要添加空白按钮和删除按钮
    */


    /*
    添加快速构造方法来设置标识init(isRemoveButton: Bool)
    1.表情分组跳转根据toobar的tag
    collectionVeiw.scrollToItemAtIndexPath(NSIndexPath(forItem: 0, inSection: item.tag)
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
    
    //MARK: - 初始化UI
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





