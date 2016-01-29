//
//  QRCodeViewController.swift
//  4jchc-WeiBo-Pods
//
//  Created by 蒋进 on 16/1/29.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

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
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.设置底部视图默认选中第0个
        customTabBar.selectedItem = customTabBar.items![0]
        customTabBar.delegate = self
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        startAnimation()
        
    }
    
    /**
     执行动画
     */
    private func startAnimation(){
        
//        // 让约束从顶部开始
//        self.scanLineCons.constant = -self.containerHeightCons.constant
//        
//        print("self.scanLineCons.constant==\(self.scanLineCons.constant)")
//       // self.scanLineView.layoutIfNeeded()
//        
//        // 执行冲击波动画
//        UIView.animateWithDuration(2.0, animations: { () -> Void in
//            // 1.修改约束
//            self.scanLineCons.constant = self.containerHeightCons.constant
//            // 设置动画指定的次数
//            UIView.setAnimationRepeatCount(MAXFLOAT)
//            // 2.强制更新界面
//            self.scanLineView.layoutIfNeeded()
//        })
        
        
        // 让约束从顶部开始
        self.scanLineCons.constant = -self.containerHeightCons.constant-300
        // 1.修改约束
        self.scanLineCons.constant = self.containerHeightCons.constant
        
        print("self.scanLineCons.constant==\(self.scanLineCons.constant)")

        
        // 执行冲击波动画
        UIView.animateWithDuration(2.0, animations: { () -> Void in
            //self.scanLineView.setNeedsUpdateConstraints()
            // 设置动画指定的次数
            UIView.setAnimationRepeatCount(MAXFLOAT)
            // 2.强制更新界面
            self.scanLineView.layoutIfNeeded()
        })
        
        
        
        
        
        
    }
    
    // MARK: - UITabBarDelegate
    func tabBar(tabBar: UITabBar, didSelectItem item: UITabBarItem) {
        
        // 1.修改容器的高度
        if item.tag == 1{
            //            print("二维码")
            self.containerHeightCons.constant = 300
        }else{
            print("条形码")
            self.containerHeightCons.constant = 150
        }
        
        // 2.停止动画
      
        //self.scanLineView.layer.removeAllAnimations()
        self.scanLineView.layoutIfNeeded()
        // 3.重新开始动画
        startAnimation()
    }

}
