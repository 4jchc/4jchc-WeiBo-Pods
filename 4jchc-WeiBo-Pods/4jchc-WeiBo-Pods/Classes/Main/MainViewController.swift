//
//  MainViewController.swift
//  4jchc-WeiBo-Pods
//
//  Created by 蒋进 on 16/1/27.
//  Copyright © 2016年 蒋进. All rights reserved.
//【WeiBo-Pods】01初始化项目

import UIKit
/*
command + shift + j -> 定位到当前文件的目录结构
⬆️⬇️键选择文件夹
按回车 -> command + c 拷贝文件名称
command + n 创建文件
*/
class MainViewController: UITabBarController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置当前控制器对应tabBar的颜色
        //MARK: -  注意: 在iOS7以前如果设置了tintColor只有文字会变, 而图片不会变
        tabBar.tintColor = UIColor.orangeColor()
        
        /*
        // 1.创建首页
        let home = HomeViewController()
        // 1.1设置首页tabbar对应的数据
        home.tabBarItem.image = UIImage(named: "tabbar_home")
        home.tabBarItem.selectedImage = UIImage(named: "tabbar_home_highlighted")
        //        home.tabBarItem.title = "首页"
        
        // 1.2设置导航条对应的数据
        //        home.navigationItem.title = "首页"
        home.title = "首页"
        
        // 2.给首页包装一个导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(home)
        
        // 3.将导航控制器添加到当前控制器上
        addChildViewController(nav)
        */
        
        addChildViewController(HomeViewController(), title: "首页", imageName: "tabbar_home")
        addChildViewController(MessageViewController(), title: "消息", imageName: "tabbar_message_center")
        addChildViewController(DiscoverViewController(), title: "广场", imageName: "tabbar_discover")
        addChildViewController(ProfileViewController(), title: "我", imageName: "tabbar_profile")
        
    }
    /**
     初始化子控制器
     
     :param: childController 需要初始化的子控制器
     :param: title           子控制器的标题
     :param: imageName       子控制器的图片
     */
    private func addChildViewController(childController: UIViewController, title:String, imageName:String) {
        
        // 1设置首页对应的数据
        childController.tabBarItem.image = UIImage(named: imageName)
        childController.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        childController.title = title
        
        // 2.给首页包装一个导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(childController)
        
        // 3.将导航控制器添加到当前控制器上
        addChildViewController(nav)
    }
    


}
