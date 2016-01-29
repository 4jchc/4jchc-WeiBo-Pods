//
//  PopoverViewController.swift
//  4jchc-WeiBo-Pods
//
//  Created by 蒋进 on 16/1/29.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class PopoverViewController: UIViewController,UITableViewDataSource {

    
    @IBOutlet weak var tableView: UITableView!
    //控制器里已经设置了标识
   // let identifer:String = "customCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 如果设置了空一个控件的frame或size之后, 大小不对, 那么可以尝试禁止autoresizing
        //        view.autoresizingMask = UIViewAutoresizing.None
        //        tableView.autoresizingMask = UIViewAutoresizing.None
        
    }
    
    // MARK: - UITableViewDataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 15
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("customCell")!
        cell.textLabel!.text = "我是第 \(indexPath.row) 行"
        return cell
    }

}
