//
//  开发笔记.swift
//  01-TextKit基本使用
//
//  Created by 蒋进 on 16/2/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//



/*

 textStorage 专门用于存储内容的 中有 layoutManager
 layoutManager 专门用于管理布局 中有 textContainer
 textContainer 专门用于指定绘制的区域

1.重写UILabel的text属性Didset方法获取text
 修改textStorage存储的内容
textStorage.setAttributedString(NSAttributedString(string: text!))

2.如果是UILabel调用setNeedsDisplay方法, 系统会促发drawTextInRect
重绘-> layoutManager.draw Glyphs字形 ForGlyphRange(NSMakeRange(0, text!.characters.count), atPoint: CGPointZero)
3.指定区域
textContainer.size = bounds.size
4.替换属性文本
textStorage.replaceCharactersInRange(checkingRes.range, withAttributedString: tempStr)
*/