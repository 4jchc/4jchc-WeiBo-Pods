//
//  BaseTableViewController.swift
//  4jchc-WeiBo-Pods
//
//  Created by 蒋进 on 16/1/27.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class BaseTableViewController: UITabBarController {

    // 定义一个变量保存用户当前是否登录
    var userLogin = false
    
    override func loadView() {
        
        userLogin ? super.loadView() : setupVisitorView()
    }
    
    // MARK: - 内部控制方法
    /**
    创建未登录界面
    */
    private func setupVisitorView()
    {
        let customView = VisitorView()
        view = customView
        
    }



}
