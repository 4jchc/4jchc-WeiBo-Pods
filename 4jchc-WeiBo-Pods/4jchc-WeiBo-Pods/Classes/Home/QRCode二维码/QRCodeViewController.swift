//
//  QRCodeViewController.swift
//  4jchc-WeiBo-Pods
//
//  Created by 蒋进 on 16/1/29.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class QRCodeViewController: UIViewController {


    @IBAction func closeBtnClick(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }
    /// 底部视图
    @IBOutlet weak var customTabBar: UITabBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1.设置底部视图默认选中第0个
        customTabBar.selectedItem = customTabBar.items![0]
        
    }

}
