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


