//
//  QRCodeViewController.swift
//  4jchc-WeiBo-Pods
//
//  Created by 蒋进 on 16/1/29.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
import AVFoundation
class QRCodeViewController: UIViewController ,UITabBarDelegate{


    @IBAction func closeBtnClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    /// 底部视图
    @IBOutlet weak var customTabBar: UITabBar!
    
    /// 扫描容器高度约束
    @IBOutlet weak var containerHeightCons: NSLayoutConstraint!
    /// 冲击波视图
    @IBOutlet weak var scanLineView: UIImageView!
    /// 冲击波视图顶部约束
    @IBOutlet weak var scanLineCons: NSLayoutConstraint!
    
    /// 保存扫描到的结果
    @IBOutlet weak var resultLabel: UILabel!
    
    
    //MARK: - 击生成二维码
    @IBAction func myCardBtnClick(sender: AnyObject) {
        
        let vc = QRCodeCardViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    private let ScreenWidth = UIScreen.mainScreen().bounds.size.width
    private let ScreenHeight = UIScreen.mainScreen().bounds.size.height
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.设置底部视图默认选中第0个
        customTabBar.selectedItem = customTabBar.items![0]
        customTabBar.delegate = self
        // 2.设置标题
        navigationItem.title = "二维码扫描"
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        //执行动画
        startAnimation()
        // 2.开始扫描
        startScan()
    }
    
    //MARK: 二维码动画
    ///执行动画
    private func startAnimation(){
        
//         //让约束从顶部开始
//        self.scanLineCons.constant = -self.containerHeightCons.constant
//        // 执行冲击波动画
//        UIView.animateWithDuration(2.0, animations: { () -> Void in
//            // 1.修改约束
//            self.scanLineCons.constant = 0
//            // 设置动画指定的次数
//            UIView.setAnimationRepeatCount(MAXFLOAT)
//            // 2.强制更新界面
//            self.scanLineView.layoutIfNeeded()
//            
//  
//        })
        

        self.scanLineView.alpha = 0.1
        self.scanLineCons.constant = -self.containerHeightCons.constant
        //self.scanLineView.layoutIfNeeded()//会变形
        self.view.layoutIfNeeded()
        UIView.animateWithDuration(1.5, animations: { () -> Void in
            
            // 设置动画指定的次数
            UIView.setAnimationRepeatCount(MAXFLOAT)
            self.scanLineCons.constant = 0
            self.scanLineView.alpha = 1
            // 2.更新界面
            self.view.layoutIfNeeded()
        })

        

        
        
//        // 让约束从顶部开始
//        self.scanLineCons.constant = -self.containerHeightCons.constant
//        // 1.修改约束
//        self.scanLineCons.constant = 0
//        // 执行冲击波动画
//        UIView.animateWithDuration(2.0, animations: { () -> Void in
//            self.scanLineView.setNeedsUpdateConstraints()
//            // 设置动画指定的次数
//            UIView.setAnimationRepeatCount(MAXFLOAT)
//            // 2.强制更新界面
//            self.scanLineView.layoutIfNeeded()
//        })

    }
    
    // MARK: - UITabBarDelegate
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        // 1.修改容器的高度
        if item.tag == 1{
            print("二维码")
            self.containerHeightCons.constant = 300
        }else{
            print("条形码")
            self.containerHeightCons.constant = 150
            navigationItem.title = "条形码扫描"
        }
        
        // 2.停止动画
        self.scanLineView.layer.removeAllAnimations()
        self.scanLineView.layoutIfNeeded()
        // 3.重新开始动画
        startAnimation()
    }


 
    //MARK: - 扫描二维码
    private func startScan(){
        
        // 1.判断是否能够将输入添加到会话中
        if !session.canAddInput(deviceInput)
        {
            return
        }
        // 2.判断是否能够将输出添加到会话中
        if !session.canAddOutput(output)
        {
            return
        }
        // 3.将输入和输出都添加到会话中
        session.addInput(deviceInput)
        session.addOutput(output)
        
        // 高质量采集率
        session.sessionPreset = AVCaptureSessionPresetHigh
        
        //设置扫码支持的编码格式(如下设置条形码和二维码兼容)
        output.metadataObjectTypes=[AVMetadataObjectTypeQRCode,AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeCode128Code];
        
        // 4.设置输出能够解析的数据类型
        // 注意: 设置能够解析的数据类型, 一定要在输出对象添加到会员之后设置, 否则会报错
        output.metadataObjectTypes =  output.availableMetadataObjectTypes
        print(output.availableMetadataObjectTypes)
        
        // 5.设置输出对象的代理, 只要解析成功就会通知代理
        output.setMetadataObjectsDelegate(self, queue: dispatch_get_main_queue())
        
        //MARK:  感兴趣的区域，设置为中心，否则全屏可扫
        self.output.rectOfInterest = CGRectMake(((ScreenHeight-220)/2)/ScreenHeight, ((ScreenWidth-220)/2)/ScreenWidth, 220/ScreenHeight, 220/ScreenWidth)
 
        // 添加预览图层
        view.layer.insertSublayer(previewLayer, atIndex: 0)
        print("view\(view.frame)")
        
        //MARK:  添加绘制图层到预览图层上
        previewLayer.addSublayer(drawLayer)
        
        // 6.告诉session开始扫描
        session.startRunning()
        
    }
    
    
    
    // MARK: - 懒加载二维码--会话--对象--预览图层
    // 会话
    private lazy var session : AVCaptureSession = AVCaptureSession()
    
    // 拿到输入设备
    private lazy var deviceInput: AVCaptureDeviceInput? = {
        // 获取摄像头
        let device = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)
        do{
            // 创建输入对象
            let input = try AVCaptureDeviceInput(device: device)
            return input
        }catch
        {
            print(error)
            return nil
        }
    }()
    
    // 拿到输出对象
    private lazy var output: AVCaptureMetadataOutput = AVCaptureMetadataOutput()
    
    // 创建预览图层
    private lazy var previewLayer: AVCaptureVideoPreviewLayer = {
        let layer = AVCaptureVideoPreviewLayer(session: self.session)
        //MARK: 扫描全屏黑
        layer.videoGravity = AVLayerVideoGravityResizeAspectFill
        //layer.frame = self.view.layer.bounds
        layer.frame = UIScreen.mainScreen().bounds
        print("创建预览图层\(layer.frame)--\(UIScreen.mainScreen().bounds.size.width)")
        return layer
    }()
    
    
    
    //MARK: - 定位二维码图层
    // 创建用于绘制边线的图层
    private lazy var drawLayer: CALayer = {
        let layer = CALayer()
        layer.frame = UIScreen.mainScreen().bounds//为二维码的大小
        print("绘制边线的图层\(layer.frame)--\(UIScreen.mainScreen().bounds.size.width)")
        return layer
    }()
    
}

extension QRCodeViewController: AVCaptureMetadataOutputObjectsDelegate
{
    // 只要解析到数据就会调用
    func captureOutput(captureOutput: AVCaptureOutput!, didOutputMetadataObjects metadataObjects: [AnyObject]!, fromConnection connection: AVCaptureConnection!)
    {
        // 0.清空图层
        clearConers()
        
        // 1.获取扫描到的数据
        // 注意: 要使用stringValue
        //        print(metadataObjects.last?.stringValue)
        resultLabel.text = metadataObjects.last?.stringValue
        resultLabel.sizeToFit()
        
        // 2.获取扫描到的二维码的位置
        //        print(metadataObjects.last)
        // 2.1转换坐标
        for object in metadataObjects
        {
            // 2.1.1判断当前获取到的数据, 是否是机器可识别的类型
            if object is AVMetadataMachineReadableCodeObject
            {
                // 2.1.2将坐标转换界面可识别的坐标
                let codeObject = previewLayer.transformedMetadataObjectForMetadataObject(object as! AVMetadataObject) as! AVMetadataMachineReadableCodeObject
                //                print(codeObject)
                // 2.1.3绘制图形
                drawCorners(codeObject)
            }
        }
        
        //MARK: - 打开网页
        /*
        var stringValue:String?
        if metadataObjects.count > 0 {
            let metadataObject = metadataObjects[0] as! AVMetadataMachineReadableCodeObject
            stringValue = metadataObject.stringValue
        }else{
            return
        }

        //解析二维码后的值
        let urlString = stringValue ?? ""
        //设置正则表达式规则
        let regexString = "http(s)?:\\/\\/([\\w-]+\\.)+[\\w-]+(\\/[\\w- .\\/?%&=]*)?"
        
 
        //根据正则规则判断解析出来的值是否合法
       
        let regex:NSRegularExpression = try! NSRegularExpression(pattern: regexString, options: NSRegularExpressionOptions.CaseInsensitive)
        let result:NSTextCheckingResult? = regex.firstMatchInString(urlString, options: NSMatchingOptions(), range: NSMakeRange(0, (urlString as NSString).length))
        //如果合法则调用系统系统openURL处理url（调用系统浏览器打开URL）,否则弹出警告框
        if result != nil {
            UIApplication.sharedApplication().openURL(NSURL(string: urlString)!)
            print("\(urlString)\n")
        }else{
            print("非法的URL")
        }

        */
        
        
        
    }
    
    /**
     绘制图形
     :param: codeObject 保存了坐标的对象
     */
    //MARK: - 绘制图形
    private func drawCorners(codeObject: AVMetadataMachineReadableCodeObject)
    {
        if codeObject.corners.isEmpty
        {
            return
        }
        
        // 1.创建一个图层
        let layer = CAShapeLayer()
        layer.lineWidth = 8
        layer.strokeColor = UIColor.redColor().CGColor
        layer.fillColor = UIColor.clearColor().CGColor//不设置会黑
        
        // 2.创建路径
        //        layer.path = UIBezierPath(rect: CGRect(x: 100, y: 100, width: 200, height: 200)).CGPath
        let path = UIBezierPath()
        var point = CGPointZero
        var index: Int = 0
        // 2.1移动到第一个点
        //        print(codeObject.corners.last)
        // 从corners数组中取出第0个元素, 将这个字典中的x/y赋值给point
        CGPointMakeWithDictionaryRepresentation((codeObject.corners[index++] as! CFDictionaryRef), &point)
        path.moveToPoint(point)
        
        // 2.2移动到其它的点
        while index < codeObject.corners.count
        {
            CGPointMakeWithDictionaryRepresentation((codeObject.corners[index++] as! CFDictionaryRef), &point)
            path.addLineToPoint(point)
        }
        // 2.3关闭路径
        path.closePath()
        // 2.4绘制路径
        layer.path = path.CGPath
        
        // 3.将绘制好的图层添加到drawLayer上
        drawLayer.addSublayer(layer)
    }

    //MARK: - 清空边线
    private func clearConers(){
        // 1.判断drawLayer上是否有其它图层
        if drawLayer.sublayers == nil || drawLayer.sublayers?.count == 0{
            return
        }
        
        // 2.移除所有子图层
        for subLayer in drawLayer.sublayers!
        {
            subLayer.removeFromSuperlayer()
        }
    }
    
    
}