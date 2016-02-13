//
//  XMGTextView.swift
//  WeiBo-TextKit
//
//  Created by 蒋进 on 16/2/13.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGTextView: UITextView {
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        // 1.获取手指点击的位置
        let touch = (touches as NSSet).anyObject()!
        let point = touch.locationInView(touch.view)
        
        print(point)
        
        // 2.获取URL的区域
        // 注意: 没有办法直接设置UITextRange的范围
        let range = NSMakeRange(10, 20)
        // 只要设置selectedRange, 那么就相当于设置了selectedTextRange
        selectedRange = range
        
        // 给定指定的range, 返回range对应的字符串的rect
        // 返回数组的原因是因为文字可能换行
        let array = selectionRectsForRange(selectedTextRange!)
        
        for selectionRect in array{
            //            let tempView = UIView(frame: selectionRect.rect)
            //            tempView.backgroundColor = UIColor.redColor()
            //            addSubview(tempView)
            
            if CGRectContainsPoint(selectionRect.rect, point)
            {
                print("点击了URL")
            }
        }
  
    }
}