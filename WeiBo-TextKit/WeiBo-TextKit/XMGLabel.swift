//
//  XMGLabel.swift
//  WeiBo-TextKit
//
//  Created by 蒋进 on 16/2/13.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class XMGLabel: UILabel {
    
    override var text: String?
        {
        didSet{
            // 1.修改textStorage存储的内容
            textStorage.setAttributedString(NSAttributedString(string: text!))
            
            // 2.设置textStorage的属性
            textStorage.addAttribute(NSFontAttributeName, value: UIFont.systemFontOfSize(20), range: NSMakeRange(0, text!.characters.count))
            
            // 3.处理URL
            self.URLRegex()
            
            // 2.通知layoutManager重新布局
            setNeedsDisplay()
        }
    }
    
    // 如果是UILabel调用setNeedsDisplay方法, 系统会促发drawTextInRect
    override func drawTextInRect(rect: CGRect) {
        // 重绘
        // 字形 ; 理解为一个小的UIView
        /*
        第一个参数: 指定绘制的范围
        第二个参数: 指定从什么位置开始绘制
        */
        layoutManager.drawGlyphsForGlyphRange(NSMakeRange(0, text!.characters.count), atPoint: CGPointZero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupSystem()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupSystem()
    }
    
    private func setupSystem()
    {
        // 1.将layoutManager添加到textStorage
        textStorage.addLayoutManager(layoutManager)
        // 2.将textContainer添加到layoutManager
        layoutManager.addTextContainer(textContainer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // 3.指定区域
        textContainer.size = bounds.size
    }
    
    // MARK: -懒加载
    /*
    只要textStorage中的内容发生变化, 就可以通知layoutManager重新布局
    layoutManager重新布局需要知道绘制到什么地方, 所以layoutManager就会文textContainer绘制的区域
    */
    
    // 准们用于存储内容的
    // textStorage 中有 layoutManager
    private lazy var textStorage = NSTextStorage()
    
    // 专门用于管理布局
    // layoutManager 中有 textContainer
    private lazy var layoutManager = NSLayoutManager()
    
    // 专门用于指定绘制的区域
    private lazy var textContainer = NSTextContainer()
    
    
    func URLRegex()
    {
        
        
        // 1.创建一个正则表达式对象
        do{
            let dataDetector = try NSDataDetector(types: NSTextCheckingTypes(NSTextCheckingType.Link.rawValue))
            
            let res =  dataDetector.matchesInString(textStorage.string, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, textStorage.string.characters.count))
            
            // 4取出结果
            for checkingRes in res
            {
                let str = (textStorage.string as NSString).substringWithRange(checkingRes.range)
                let tempStr = NSMutableAttributedString(string: str)
                
                //                tempStr.addAttribute(NSForegroundColorAttributeName, value: UIColor.redColor(), range: NSMakeRange(0, str.characters.count))
                tempStr.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(20), NSForegroundColorAttributeName: UIColor.redColor()], range: NSMakeRange(0, str.characters.count))
                
                textStorage.replaceCharactersInRange(checkingRes.range, withAttributedString: tempStr)
            }
        }catch
        {
            print(error)
        }
        
    }
    
}
