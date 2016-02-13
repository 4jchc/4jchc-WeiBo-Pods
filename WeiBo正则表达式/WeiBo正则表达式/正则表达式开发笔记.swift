//
//  正则表达式开发笔记.swift
//  WeiBo正则表达式
//
//  Created by 蒋进 on 16/2/13.
//  Copyright © 2016年 蒋进. All rights reserved.
//

    /*
    1.案例
     注意点: 正则表达式会匹配整个字符串, 如果前面不匹配会继续往后匹配
     1.创建规则
    let pattern = "[1-9][0-9]{4,14}"
     2.创建正则表达式对象
    /*
    第一个参数: 匹配的规则
    第二个参数: 附加选项
    */
    let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
     3.开始匹配
    let res = regex.matchesInString(str, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
    for checkingRes in res
    */

