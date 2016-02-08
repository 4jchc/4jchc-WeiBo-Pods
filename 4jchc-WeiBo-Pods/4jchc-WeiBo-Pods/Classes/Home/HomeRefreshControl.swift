//
//  HomeRefreshControl.swift
//  DSWeibo
//
//  Created by xiaomage on 15/9/14.
//  Copyright © 2015年 小码哥. All rights reserved.
//

import UIKit

class HomeRefreshControl: UIRefreshControl {

    override init() {
        super.init()
        
        setupUI()
    }

    private func setupUI()
    {
        // 1.添加子控件
        addSubview(refreshView)
        
        // 2.布局子控件
        refreshView.xmg_AlignInner(type: XMG_AlignType.Center, referView: self, size: CGSize(width: 170, height: 60))
        
        /*
        1.当用户下拉到一定程度的时候需要旋转箭头
        2.当用户上推到一定程度的时候需要旋转箭头
        3.当下拉刷新控件触发刷新方法的时候, 需要显示刷新界面(转轮)
        
        通过观察:
        越往下拉: 值就越小
        越往上推: 值就越大
        */
        //MARK: KVO监听Observer观察者
        addObserver(self, forKeyPath: "frame", options: NSKeyValueObservingOptions.New, context: nil)
    }
    
    
    /// 定义变量记录是否需要旋转监听
    private var rotationArrow = false
    
    override func observeValueForKeyPath(keyPath: String?, ofObject object: AnyObject?, change: [String : AnyObject]?, context: UnsafeMutablePointer<Void>) {
        print(frame.origin.y)
        
        // 过滤掉不需要的数据
        if frame.origin.y >= 0
        {
            return
        }
        
        if frame.origin.y >= -50 && !rotationArrow
        {
            print("翻转")
            rotationArrow = true
        }else if frame.origin.y < -50 && rotationArrow
        {
            print("翻转回来")
            rotationArrow = false
        }
    }
    
    deinit
    {
        removeObserver(self, forKeyPath: "frame")
    }
    
    
    

    // MARK: - 懒加载
    private lazy var refreshView : HomeRefreshView =  HomeRefreshView.refreshView()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


class HomeRefreshView: UIView
{
    class func refreshView() -> HomeRefreshView
    {
        return NSBundle.mainBundle().loadNibNamed("HomeRefreshView", owner: nil, options: nil).last as! HomeRefreshView
    }
}


