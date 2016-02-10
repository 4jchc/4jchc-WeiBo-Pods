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

//MARK: - 注释第四天


    /*
    //MARK: 1. 获取微博数据
    1.闭包回调的使用--通过闭包将数据传递给调用者
    */

    /*
    //MARK: 2. 加载用户数据-(字典里嵌套字典)
    1.KVC--setValuesForKeysWithDictionary内部会调用以下方法
    setValue(value: AnyObject?, forKey key: String)
    2.KVC内部调用setValue-拦截--字典--再进行字典转模型
    */

    /*
    //MARK: 3. 布局基本界面
    1.预估行高.自动调节尺寸
    tableView. estimated--估计的 RowHeight = 200
    tableView.rowHeight = UITableView Automatic自动的 Dimension-尺寸
    3.tableView. separator:分隔符 Style = UITableViewCellSeparatorStyle.None
    */


    /*
    //MARK: 4. 完善界面代码.抽取lable和uibutton
    1.UILabel纯代码自动布局要设置(自动布局的宽度)-preferred-优先的 Max-最大 LayoutWidth不然不会换行
    */

    /*
    //MARK: 5. 设置--用户头像MVC--认证图标
    1.view用来展示数据Model用来加载数据在didSet方法中设置接收的值
    */


    /*
    //MARK: 6. 设置--会员等级图标--微博来源
    1.KVC基本数据类型要先赋值
    2.字符串的截取 rangeOfString获取开始截取的位置 截取位置substringWithRange
    */

    /*
    //MARK: 7.设置微博时间
    1.NS Calendar-日历的使用
    */

    /*
    //MARK: 8.缓存图片
    1.图片异步下载-使用GCD建立一个group dispatch_group_create()
    进入当前组dispatch_group_enter(group)  离开当前组 dispatch_group_leave(group)

    2.当所有图片都下载完毕group再通过闭包通知调用者
    dispatch_group_notify通知(group, dispatch_get_main_queue()) { () -> Void in
    能够来到这个地方, 一定是所有图片都下载完毕---在调用闭包
    finished(models: list, error: nil)
    
    3.闭包回调嵌套闭包回调
    4.自定义在DEBUG下的打印print
    */

    /*
    //MARK: 9.计算配图尺寸 & 显示配图
    1.元组的使用.有2个返回值
    2.获取自动布局Constraint约束的属性
    --pictureView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Width)
    */


    /*
    //MARK: 10.缓存行高
    1.利用字典作为容器. key就是微博的id, 值就是对应微博的行高
    2.内存警告清除字典 removeAll()
    3.预估行高，可以提高性能
    */

    /*
    //MARK: 11.代码重构
    1.新建-顶部view-中部lable-UICollectionView-底部view类
    */

//MARK: - 💗注释第五天

    /*
    //MARK: 1 布局转发微博
    1.cell的继承开发,相同的放在父类里.不同的放在子类
    2.记录picture-cell的顶部约束.判断正文与底部的间距
    3.测试只要修改注册cell时的类型
    */


    /*
    //MARK: 2 完善转发微博
    1.KVC内部调用setValue-拦截转发微博--字典--再进行字典转模型
    2.定义枚举--来切换注册的cell标识
    3.DidSet方法中赋值或者设置刷新-reloadData()
    */

    /*
    //MARK: 3 添加自定义刷新控件
    1.模型赋值Didset方法的重写
    2.自定义刷新view继承UIRefreshControl.设置旋转的view或者下拉的view的一个隐藏
    3.使用小马哥的自动布局代码刷新控件的view要设置尺寸
    找不到断点在哪里
    4.点击菜单Debug--> workflow取消选中show Disassembly分解 when debug
    */

    /*
    //MARK: 4 1.KVO监听frame的改变会调用
    observeValueForKeyPath
    2.添加KVO案例代码段
    */

    /*
    //MARK: 5 下拉刷新动画
    1.自定义刷新控件refreshControl = HomeRefreshControl()
    添加方法addTarget在方法中停止动画 self.refreshControl?.endRefreshing()
    2.重写endRefreshing 复位标记
    3.添加旋转-动画-代码段
    */

    /*
    //MARK: 6 加载下拉刷新数据
    1.在原加载微博数据的方法loadData添加--属性判断id大小刷新数据
    2.缓存图片判断.如果没有数据直接完成
    */

    /*
    //MARK: 7 添加刷新提示lable
    1.加载lable插入navBar 下面，不然会随着 tableView 一起滚动
    self.navigationController?.navigationBar.insertSubview(label, atIndex: 0)
    2.根据id返回的数据个数决定提示的值
    */

    /*
    //MARK: 8 添加上拉刷新
    1.利用tableview的cell.row.是最后一个的时候加载数 据接着定义一个标记
    2.上拉--下拉的判断.
    3.字典模型拼接用+号
    */

    /*
    //MARK: 9 添加大图地址.Didset方法中设置需要的大图
    1.stringByReplacingOccurrencesOfString替换字符串
    */


    /*
    //MARK: 10 大图界面布局
    1.出现错误--"error":"User requests out of rate limit!","error_code":10023, 请求次数超出限制
    */

    /*
    //MARK: 11 显示大图
    1.按照宽高比设置图片
    2.自定义 UICollectionViewFlowLayout
    3.自定义cell UICollectionViewCell
    */

    /*
    //MARK: 12 图片居中显示 -长图-短图判断
    */


    /*
    //MARK: 13 图片缩放 添加菊花
    1.设置scrollview的代理
    2.cell重用要还原设置
    3.下载图片之前-添加菊花标志
    */

    /*
    //MARK: 14 点击图片退出控制器
    1.添加代理->监听图片点击->控制器销毁控制器
    2.添加手势识别
    */

    /*
    保存图片
    1.拿到当前正在显示的cell  Visible可见的
    let index = collectionView.indexPathsForVisibleItems().last!
    let cell = collectionView.cellForItemAtIndexPath(index) as! PhotoBrowserCell
    2.保存图片
    let image = cell.iconView.image
    UIImageWriteToSavedPhotosAlbum(image!, self, "image:didFinishSavingWithError:contextInfo:", nil)
    3.保存图片会调用
    func image(image:UIImage, didFinishSavingWithError error:NSError?, contextInfo:AnyObject)
    */









