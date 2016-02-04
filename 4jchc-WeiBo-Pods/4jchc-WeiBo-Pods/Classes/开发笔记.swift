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
    0.显示标题菜单💗
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
    3.自定义转场的动画💗
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
    2.自动布局一般要设置宽高XY4个💗
    0.1X轴有top-botton-center+Horizontally3个选项
    0.2Y轴有leading-trailing-center+Vertically3个选项
    0.3 leading靠前 trailing靠后拖尾
    */


    /*
    二维码界面动画
    1.模拟器bug真机运行可以
    */

    /*
    二维码扫描步奏
     0.import AVFoundation
     0.1懒加载--会话 --输出对象 --输入设备 --创建预览图层
     1.判断是否能够将输入添加到会话中 AVCaptureDeviceInput
     2.判断是否能够将输出添加到会话中 AVCaptureMetadataOutput
     3.将输入和输出都添加到会话中   AVCaptureSession
     4.设置输出能够解析的数据类型   availableMetadataObjectTypes
     注意: 设置能够解析的数据类型, 一定要在输出对象添加到会员之后设置, 否则会报错
     output.metadataObjectTypes =  output.availableMetadataObjectTypes
     5.设置输出对象的代理, 只要解析成功就会通知代理
     output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
     6.添加预览图层 AVCaptureVideoPreviewLayer
     7.告诉session开始扫描
     8.AVCaptureMetadataOutputObjectsDelegate代理方法实现
    */


    /*
    💗二维码定位
    1.创建用于绘制边线的图层
    2.获取扫描到的数据 要使用stringValue
    3.转换坐标遍历获取坐标for object in metadataObjects
    4.判断当前获取到的数据, 是否是机器可识别的类型AVMetadataMachineReadableCodeObject
    5.将坐标转换成界面可识别的坐标
    previewLayer.transformedMetadataObjectForMetadataObject(object as! AVMetadataObject) as! AVMetadataMachineReadableCodeObject
    💗绘制图形
    1.创建一个图层
    2.创建路径--移动到点--关闭路径--绘制路径--添加到drawLayer上
    3.添加代码段
    4.从corners数组中取出第0个元素, 将这个字典中的x/y赋值给point
    💗CGPointMakeWithDictionaryRepresentation((codeObject.corners[index++] as! CFDictionaryRef), &point)
    */


    /*
    完善二维码动画self.view.layoutIfNeeded()不用设置NSLayoutConstraint的layoutIfNeeded()(已经真机测试)
    1.设置动画指定的次数要💗放在动画执行的前面
     UIView.setAnimationRepeatCount(MAXFLOAT)
    2.添加一个NSLayoutConstraint的动画快捷键
    */

    /*
    生成二维码

    A1添加限制扫描区域 rectOfInterest兴趣
    A2摄像头是全屏显示 videoGravity

    1.创建滤镜Filter CIFilter(name: "CIQRCodeGenerator")
    2.还原滤镜的默认属性 setDefaults()
    3.设置需要生成二维码的数据 setValue("".dataUsingEncoding(NSUTF8StringEncoding), forKey: "inputMessage")
    4.从滤镜中取出生成好的图片 outputImage
    5.创建一个头像
    6.合成图片(将二维码和头像进行合并)
    7.返回生成好的二维码
    */


    


    /*
    添加cocopods的xcode插件
    1.use_frameworks!
     pod 'AFNetworking'
     pod 'SDWebImage'
     pod 'SVProgressHUD'

    2.报错 :Resolved command path for "pod" is invalid.有病的
    Expanded GEM_PATH: /usr/bin 修改为 :/usr/local/bin
    3.试了第三次又可以了,所以没有改
    4.修改生成二维码时的图片是空.和导航栏标题文字颜色
    */

    /*如果真机运行错误
    1.设置build phases 里添加copy files Destination:framework pods.framework
    */
//MARK: - 注释第三天

    //<key>NSAppTransportSecurity</key> Transport 运输 Security 安全(保护,保证
    //<dict>
    //<key>NSAllowsArbitraryLoads</key>
    //<true/>
    //</dict>

    /*
    加载授权页面.把授权页面包装成导航控制器
    1.http网络请求设置 NSAppTransportSecurity dict NSAllowsArbitraryLoads true
    2.Transport 运输 Security 安全(保护,保证 Arbitrary任意的(随机的,独立的
    */



    /*
    获取已经授权RequestToken
    1.url转字符串request.URL!.absoluteString
    2.request.URL!.query? 获取query查询?后面的字符串
    3.codeStr.endIndex是拿到code=最后的位置
    */


    /*
    获取AccessToken
    1.AFN单例--baseURL一定要以/结尾
    2.设置AFN能够接收得数据类型 responseSerializer.acceptableContentTypes
    💗response响应 Serializer串行器转换数据模型为RDF/XML格式.acceptable可接受的 Content内容Types类型
    AFN的POST请求更新了带进度的方法
    */

    /*
    保存授权信息
    1.重写description打印信息
    2.AFN返回的JSON是字典对象anyobject->as [String : AnyObject]
    3.归档保存 1.字典转模型 2.归档模型
    */


    /*
    1.优化代码
    2.保存登录状态
    3.添加加载页面提示
    */

    /*
    判断授权信息是否过期
    1.新增expires_Date保存用户过期时间 一定要归档
    2.KVC找不到的值要设置忽略setValuesForKeysWithDictionary
    重写 setValue(value: AnyObject?, forUndefinedKey key: String)
    */


    /*
    获取用户信息
    1.利用闭包回调传值
    2.新增的变量 一定要归档
    */

    /*
    添加新特性界面
    1.自定义cell---自定义FlowLayout
    2.prepareLayout()的调用顺序
     先调用一个有多少行cell 2.调用准备布局 3.调用返回cell
    */


    /*完善新特性
    1.如果当前类需要监听按钮的点击方法, 那么当前类不能是私有的
    2.新学的动画方法
    Damping--振幅 Velocity--速度
    UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity:
    */


    /*
    添加欢迎界面判断版本号
    1.代码的自动布局
    2. compare比较用法 Ordered-有序的 Descending-降序 Ascending--升序
    3.NSUserDefaults的使用--iOS7以后就不用调用同步方法了
    */

    /*
    页面跳转
    1.通知的使用
    2.A ?? B a有值是a.没值是b
    */

