//
//  WeiBo图片选择器-开发笔记.swift
//  WeiBo图片选择器
//
//  Created by 蒋进 on 16/2/12.
//  Copyright © 2016年 蒋进. All rights reserved.
//


    /*
    布局图片选择器界面
    1.VFL的使用
    2.collocation的强化学习
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