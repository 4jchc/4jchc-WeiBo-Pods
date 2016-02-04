//
//  WelcomeViewController.swift
//  4jchc-WeiBo-Pods
//
//  Created by 蒋进 on 16/2/3.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
import SDWebImage

class WelcomeViewController: UIViewController {
    
    /// 记录底部约束
    var bottomCons: NSLayoutConstraint?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.添加子控件
        view.addSubview(bgIV)
        view.addSubview(iconView)
        view.addSubview(messageLabel)
        
        // 2.布局子控件
        bgIV.xmg_Fill(view)
        
        let cons = iconView.xmg_AlignInner(type: XMG_AlignType.BottomCenter, referView: view, size: CGSize(width: 100, height: 100), offset: CGPoint(x: 0, y: -200))
        //MARK: -  拿到头像的底部约束
        bottomCons = iconView.xmg_Constraint(cons, attribute: NSLayoutAttribute.Bottom)
        
        messageLabel.xmg_AlignVertical(type: XMG_AlignType.BottomCenter, referView: iconView, size: nil, offset: CGPoint(x: 0, y: 20))
        
        // 3.设置用户头像
        if let iconUrl = UserAccount.loadAccount()?.avatar_large
        {
            let url = NSURL(string: iconUrl)!
            iconView.sd_setImageWithURL(url)
        }
    }
    //view显示的时候执行动画
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        // 约束动画
        bottomCons?.constant = -UIScreen.mainScreen().bounds.height -  bottomCons!.constant

        // -736.0 + 586.0 = -150.0
        // 图片动画
        iconView.transform = CGAffineTransformMakeScale(0.0, 0.0)
        
        // 3.执行动画
        UIView.animateWithDuration(2, delay: 0, usingSpringWithDamping: 9, initialSpringVelocity: 5, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
            
            //UIView.setAnimationRepeatCount(MAXFLOAT)
            // 头像动画
            //self.iconView.layoutIfNeeded()--->这个没有动画效果
            
            self.messageLabel.alpha = 1.0
            // 清空形变
            self.iconView.transform = CGAffineTransformIdentity
            
            self.view.layoutIfNeeded()
            }) { (_) -> Void in
                
                // 文本动画
                UIView.animateWithDuration( 0.0, delay: 0.0, usingSpringWithDamping: 6, initialSpringVelocity: 4, options: UIViewAnimationOptions(rawValue: 0), animations: { () -> Void in
                    self.messageLabel.alpha = 1.0
                    }, completion: { (_) -> Void in
                        
                        //MARK: - 发出通知跳到主页
                        NSNotificationCenter.defaultCenter().postNotificationName(XMGSwitchRootViewControllerKey, object: true)
                        print("*****欢迎界面发出通知")
                })
        }
        
    }

    
    
    
    // MARK: - 懒加载
    private lazy var bgIV: UIImageView = UIImageView(image: UIImage(named: "ad_background"))
    //MARK: - 圆形图像
    private lazy var iconView: UIImageView = {
        let iv = UIImageView(image: UIImage(named: "avatar_default_big"))
        iv.layer.cornerRadius = 50
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var messageLabel: UILabel = {
        let label = UILabel()
        label.text = "欢迎回来"
        label.sizeToFit()
        label.alpha = 0.09
        return label
    }()
}






