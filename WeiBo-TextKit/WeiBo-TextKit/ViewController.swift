//
//  ViewController.swift
//  WeiBo-TextKit
//
//  Created by 蒋进 on 16/2/13.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var customLabel: XMGLabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        customLabel.text = "欢迎来到小码哥: http://www.520it.com , 小码哥你好, 小码哥再见 http://www.baidu.com"
        
    }


}

