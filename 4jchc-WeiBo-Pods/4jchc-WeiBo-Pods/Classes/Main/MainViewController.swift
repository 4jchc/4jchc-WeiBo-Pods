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
    /*
    1.命名空间修改:product name
    2.动态获取命名空间infoDictionary!["CFBundleExecutable"]
    3.通过服务器json来动态加载节日标题图片
    */
    /*
    1.报错ns unable to read data
    2.修改命名空间(build settings)product name
    3.命名空间不可以有-
    4.修改类名
    */
    
    /*
    1.动态创建控制器
    2.添加do-catch抛出异常代码块
    3.添加json解析字典代码块
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置当前控制器对应tabBar的颜色
        //MARK: -  注意: 在iOS7以前如果设置了tintColor只有文字会变, 而图片不会变
        tabBar.tintColor = UIColor.orangeColor()
        
        
        // 添加子控制器
        addChildViewControllers()

        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        // 添加加号按钮
        setupComposeBtn()
    }
    
    /**
     监听加号按钮点击
     注意: 监听按钮点击的方法不能是私有方法
     按钮点击事件的调用是由 运行循环 监听并且以消息机制传递的，因此，按钮监听函数不能设置为 private
     */
    func composeBtnClick(){
        print(__FUNCTION__)
    }
    
    // MARK: - 内部控制方法
    private func setupComposeBtn()
    {
        // 1.添加加号按钮
        tabBar.addSubview(composeBtn)
        
        // 2.调整加号按钮的位置
        let width = UIScreen.mainScreen().bounds.size.width / CGFloat(viewControllers!.count)
        let rect  = CGRect(x: 0, y: 0, width: width, height: 49)
        //        composeBtn.frame = rect
        
        // 第一个参数:是frame的大小
        // 第二个参数:是x方向偏移的大小
        // 第三个参数: 是y方向偏移的大小
        composeBtn.frame = CGRectOffset(rect, 2 * width, 0)
    }
    
    /**
     添加所有子控制器
     */
    private func addChildViewControllers() {
        // 1.获取json文件的路径
        let path = NSBundle.mainBundle().pathForResource("MainVCSettings.json", ofType: nil)
        // 2.通过文件路径创建NSData
        if let jsonPath = path{
            let jsonData = NSData(contentsOfFile: jsonPath)
            
            do{
                // 有可能发生异常的代码放到这里
                // 3.序列化json数据 --> Array
                // try : 发生异常会跳到catch中继续执行
                // try! : 发生异常程序直接崩溃
                let dictArr = try NSJSONSerialization.JSONObjectWithData(jsonData!, options: NSJSONReadingOptions.MutableContainers)
                //                print(dictArr)
                // 4.遍历数组, 动态创建控制器和设置数据
                // 在Swift中, 如果需要遍历一个数组, 必须明确数据的类型
                for dict in dictArr as! [[String: String]]
                {
                    // 报错的原因是因为addChildViewController参数必须有值, 但是字典的返回值是可选类型
                    addChildViewController(dict["vcName"]!, title: dict["title"]!, imageName: dict["imageName"]!)
                }
                
            }catch
            {
                // 发生异常之后会执行的代码
                print(error)
                
                // 从本地创建控制器
                addChildViewController("HomeTableViewController", title: "首页", imageName: "tabbar_home")
                addChildViewController("MessageTableViewController", title: "消息", imageName: "tabbar_message_center")
                // 再添加一个占位控制器
                addChildViewController("NullViewController", title: "", imageName: "")
                addChildViewController("DiscoverTableViewController", title: "广场", imageName: "tabbar_discover")
                addChildViewController("ProfileTableViewController", title: "我", imageName: "tabbar_profile")
            }
        }
        
    }

    
    /**
     初始化子控制器
     
     :param: childController 需要初始化的子控制器
     :param: title           子控制器的标题
     :param: imageName       子控制器的图片
     */
     //    private func addChildViewController(childController: UIViewController, title:String, imageName:String) {
    private func addChildViewController(childControllerName: String, title:String, imageName:String) {
        
        //MARK: - -1.动态获取命名空间
        let ns = NSBundle.mainBundle().infoDictionary!["CFBundleExecutable"] as! String
        
        // 0 .将字符串转换为类
        // 0.1默认情况下命名空间就是项目的名称, 但是命名空间名称是可以修改的
        let cls:AnyClass? = NSClassFromString(ns + "." + childControllerName)
        // 0.2通过类创建对象
        // 0.2.1将AnyClass转换为指定的类型
        let vcCls = cls as! UIViewController.Type
        // 0.2.2通过class创建对象
        let vc = vcCls.init()
        
        // 0.1通过类创建一个对象
        
        
        // 1设置首页对应的数据
        vc.tabBarItem.image = UIImage(named: imageName)
        vc.tabBarItem.selectedImage = UIImage(named: imageName + "_highlighted")
        vc.title = title
        
        // 2.给首页包装一个导航控制器
        let nav = UINavigationController()
        nav.addChildViewController(vc)
        
        // 3.将导航控制器添加到当前控制器上
        addChildViewController(nav)
        
    }
    
    // MARK: - 懒加载
    private lazy var composeBtn:UIButton = {
        let btn = UIButton()
        
        // 2.设置前景图片
        btn.setImage(UIImage(named:"tabbar_compose_icon_add"), forState: UIControlState.Normal)
        btn.setImage(UIImage(named:"tabbar_compose_icon_add_highlighted"), forState: UIControlState.Highlighted)
        
        // 3.设置背景图片
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button"), forState: UIControlState.Normal)
        btn.setBackgroundImage(UIImage(named:"tabbar_compose_button_highlighted"), forState: UIControlState.Highlighted)
        
        // 4.添加监听
        btn.addTarget(self, action: "composeBtnClick", forControlEvents: UIControlEvents.TouchUpInside)
        return btn
    }()

}
