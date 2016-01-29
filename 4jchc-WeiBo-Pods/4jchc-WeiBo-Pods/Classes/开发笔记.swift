//
//  开发笔记.swift
//  4jchc-WeiBo-Pods
//
//  Created by 蒋进 on 16/1/27.
//  Copyright © 2016年 蒋进. All rights reserved.
//
//    【WeiBo-Pods】11
import UIKit
//MARK: - 快捷键
    /*
    💗
    command + shift + j -> 定位到当前文件的目录结构
    ⬆️⬇️键选择文件夹
    按回车 -> command + c 拷贝文件名称
    command + n 创建文件
    💗
    // command + control + e 替换文字
    💗
    //
    */




//MARK: - 注释第一天
    /*
    1.命名空间修改:product name
    2.💗动态获取命名空间infoDictionary!["CFBundleExecutable"]
    3.通过服务器json来动态加载节日标题图片
    */

    /*
    1.报错ns unable to read data
    2.修改命名空间(build settings)💗product name
    3.命名空间不可以有-
    4.修改类名
    */

    /*
    1.动态创建控制器
    2.添加do-catch抛出异常代码块
    3.添加json解析字典代码块
    */

    /*
    1.添加基类修改继承
    2.判断和创建未登录界面自定义view
    3.添加小马哥自动布局代码
    */



    /*
    1.设置view的尺寸不然图片太低了
    2.添加代理协议设置每一个控制器的view
    3.设置导航条和工具条的外观和未登录按钮
    4.完善未登录界面
    */


    /*
    1.自定义标题按钮 调整按钮位置
    2.layoutSubviews会调用2次
    3.按钮图片文字的偏移可以用offsetInPlace
    4.文字图片太挤,文字可以加空格
    */
//MARK: - 注释第二天

    /*
    0.显示标题菜单
    1.图片拉升单词:tiles平铺stretches伸长(展开,铺设;adj.弹性的)会填充屏幕
    2.默认情况下modal会移除以前控制器的view, 替换为当前弹出的view
    如果自定义转场, 那么就不会移除以前控制器的view
    3.自定义转场步奏
    01.设置代理vc?.transitioningDelegate = self
    02.设置转场的样式modalPresentationStyle.Custom
    03.实现代理方法, 告诉系统谁来负责转场动画
     presentationControllerForPresentedViewController
     iOS8推出的专门用于负责转场动画的
    4.添加转场UIPresentationController案例快捷键
    5.添加懒加载蒙版快捷键
    */


    /*
    1.完善菜单自定义动画
    2.默认的锚点是(0.5,0.5)
    3.自定义转场的动画
    0.1一定要将视图添加到容器上transitionContext.containerView()?.addSubview(toView)
    0.2动画执行完毕, 一定要告诉系统.如果不写, 可能导致一些未知错误
    transitionContext.completeTransition(true)
    */

    /*
    1.重构自定义菜单
    2.新建一个类保存转场代理 懒加载转场代理并赋值
    3.通知的使用
    */

    /*
    1.修改自定义菜单默认的背景颜色 设置为无色
    2.添加测试数据
    */


    /*
    1.二维码界面搭建
    2.自动布局一般要设置宽高XY4个
    0.1X轴有top-botton-center+Horizontally3个选项
    0.2Y轴有leading-trailing-center+Vertically3个选项
    0.3 leading靠前 trailing靠后拖尾
    */










