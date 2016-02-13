//
//  开发笔记.swift
//  01-TextKit基本使用
//
//  Created by 蒋进 on 16/2/13.
//  Copyright © 2016年 小码哥. All rights reserved.
//



    /*
    文本高亮
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

    /*
    监听url点击--文本高亮
    1.获取URL的区域
     注意: 没有办法直接设置UITextRange的范围
    let range = NSMakeRange(10, 20)
     只要设置selectedRange, 那么就相当于设置了selectedTextRange
    只有UITextView才有selectedRange
    selectedRange = range

     给定指定的range, 返回range对应的字符串的rect
     返回数组的原因是因为文字可能换行
    let array = selectionRectsForRange(selectedTextRange!)
    2.判断点的范围
    CGRectContainsPoint(selectionRect.rect, point)

    */




