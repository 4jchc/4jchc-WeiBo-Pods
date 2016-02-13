//
//  ViewController.swift
//  WeiBo正则表达式
//
//  Created by 蒋进 on 16/2/13.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet var customLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        需求: 判断一个字符串是否是QQ号码
        1.不能以0开头
        2.长度5~15
        3.必须都是数字
        */
        let str = "a12345b789456c147258"
        print(checkQQ2(str))
        phoneNum()
        weiBo()
        weiBo1()
       
        
        let str1 = "@jack12:【动物尖叫合辑】#肥猪流#猫头鹰这么https://www.520it.com 尖叫[偷笑]、@南哥: 老鼠这么[吃惊]、@江哥: 莫名奇#小笼包#妙的笑到最后[嘻嘻]！~ http://t.cn/zYBuKZ8"
        customLabel.attributedText = EmoticonPackage.emoticonString(str1)!
    }
    
    private func checkQQ2(str: String)
    {
        do{
            // 注意点: 正则表达式会匹配整个字符串, 如果前面不匹配会继续往后匹配
            // 1.创建规则
            let pattern = "[1-9][0-9]{4,14}"
            // 2.创建正则表达式对象
            /*
            第一个参数: 匹配的规则
            第二个参数: 附加选项
            */
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
            
            // 3.开始匹配
            /*
            // 匹配字符串中所有的符合规则的字符串, 返回匹配到的NSTextCheckingResult数组
            public func matchesInString(string: String, options: NSMatchingOptions, range: NSRange) -> [NSTextCheckingResult]
            
            // 按照规则匹配字符串, 返回匹配到的个数
            public func numberOfMatchesInString(string: String, options: NSMatchingOptions, range: NSRange) -> Int
            
            // 按照规则匹配字符串, 返回第一个匹配到的字符串的NSTextCheckingResult
            public func firstMatchInString(string: String, options: NSMatchingOptions, range: NSRange) -> NSTextCheckingResult?
            
            // 按照规则匹配字符串, 返回第一个匹配到的字符串的范围
            public func rangeOfFirstMatchInString(string: String, options: NSMatchingOptions, range: NSRange) -> NSRange
            
            */
            /*
            let number = regex.numberOfMatchesInString(str, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
            print("number = \(number)")
            */
            
            /*
            let res = regex.firstMatchInString(str, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
            //            print(res?.range)
            print((str as NSString).substringWithRange(res!.range))
            */
            
            /*
            let range = regex.rangeOfFirstMatchInString(str, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
            print((str as NSString).substringWithRange(range))
            */
            
            let res = regex.matchesInString(str, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
            for checkingRes in res
            {
                //                print(checkingRes.range)
                print((str as NSString).substringWithRange(checkingRes.range))
            }
            
            
        }catch
        {
            print(error)
        }
        
    }
    
    private func checkQQ(str: String) -> Bool
    {
        // 1.判断不能以0开头
        if str.hasPrefix("0")
        {
            return false
        }
        
        // 2.判断长度是否是5~15位
        let len = str.characters.count
        if len < 5 || len > 15
        {
            return false
        }
        
        // 3.判断是否都是数字
        for c in str.characters
        {
            if !(c >= "0" && c <= "9")
            {
                return false
            }
        }
        
        return true
    }
    
    func phoneNum(){
        
        /*
        匹配手机号码
        1. 以1开头
        2.第二位 3 5 7 8
        3.必须都是数字
        4.必须是11位
        */
        let str = "f13554499311fjdksj"
        do{
            let pattern = "[1][3578][0-9]{9}"
            
            // 2.创建正则表达式对象
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
            // 3.开始匹配
            let range = regex.rangeOfFirstMatchInString(str, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
            print(range)
            print((str as NSString).substringWithRange(range))
        }catch
        {
            print(error)
        }
    }
    
    func test()
    {
        let str = "_a123"
        
        do{
            // 1.定义规律
            // 判断字符串的是不是m
            //            let pattern = "[m]"
            // 判断字符串是否是字母, 注意正则表达式是区分大小写的
            //            let pattern = "[a-zA-Z]"
            // 判断是否是数字
            //            let pattern = "[0-9]"
            //            let pattern = "\\d+"
            //  Error Domain=NSCocoaErrorDomain Code=2048 是因为表达式中有中文或者空格
            //            let pattern = "[0-9]{2,3}"
            //            let pattern = "[^a-z]"
            let pattern = "\\w+"
            
            // 2.创建正则表达式对象
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
            // 3.开始匹配
            let range = regex.rangeOfFirstMatchInString(str, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
            print(range)
        }catch
        {
            print(error)
        }
        
    }
    
    func weiBo1(){
        
        let str = "@jack12:【动物尖叫合辑】#肥猪流#猫https://www.it.com头鹰这么https://www.520it.com尖叫[偷笑]、@南哥: 老鼠这么尖叫、兔子这么尖叫[吃惊]、@江哥: 莫名奇#小笼包#妙的笑到最后[挖鼻屎]！~ http://t.cn/zYBuKZ8"
        
        // 1.创建一个正则表达式对象
        do{
            let dataDetector = try NSDataDetector(types: NSTextCheckingTypes(NSTextCheckingType.Link.rawValue))
            let res =  dataDetector.matchesInString(str, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
            // 4取出结果
            for checkingRes in res
            {
                print((str as NSString).substringWithRange(checkingRes.range))
            }
        }catch
        {
            print(error)
        }
    }
    
    func weiBo()
    {
        let str = "@jack12:【动物尖叫合辑】#肥猪http://t.cn/zYBuKZ8流#猫头鹰这么尖叫[偷笑]、@南哥: 老鼠这么尖叫、兔子这么尖叫[吃惊]、@江哥: 莫名奇#小笼包#妙的笑到最后[挖鼻屎]！~ http://t.cn/zYBuKZ8"
        do{
            // 1.创建规则
            let pattern1 = "\\[.*?\\]"
            let pattern2 = "@.*?:"
            let pattern3 = "#.*?#"
            
            // 多个规则之间使用 | 符号连接
            let pattern = pattern1 + "|" + pattern2 + "|" + pattern3
            //            let pattern = "http(s)?://([\\w-]+\\.)+[\\w-]+(/[\\w- ./?%&=]*)?"
            
            // 2.创建正则表达式对象
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
            // 3.开始匹配
            let res = regex.matchesInString(str, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
            // 4取出结果
            for checkingRes in res
            {
                print(checkingRes.range)
                print((str as NSString).substringWithRange(checkingRes.range))
            }
        }catch
        {
            print(error)
        }
        
    }
    
    
    
    
    
    
    
    
    
    /*
    func weiBo3(){
        
        /*
        let str = "[爱你]"
        let emoticon = EmoticonPackage.packageList[1].emoticons?.filter({ (e) -> Bool in
        print(e.chs)
        return e.chs == str
        }).last
        print("chs = \(emoticon!.chs), imagePath = \(emoticon!.imagePath)")
        
        */
        /*
        let str = "[好爱哦]"
        let emoticon = EmoticonPackage.packageList[3].emoticons?.filter({ (e) -> Bool in
        return e.chs == str
        }).last
        print("chs = \(emoticon!.chs), imagePath = \(emoticon!.imagePath)")
        */
        
        /*
        let str = "[爱你]"
        var emoticon: Emoticon?
        for package in EmoticonPackage.packageList
        {
        emoticon = package.emoticons?.filter({ (e) -> Bool in
        return e.chs == str
        }).last
        
        if emoticon != nil{
        break
        }
        }
        print("chs = \(emoticon?.chs), imagePath = \(emoticon?.imagePath)")
        */
        
        
        // 今天[太阳]天气[云朵]非常好[good]
        
        
        let str = "@jack12:【动物尖叫合辑】#肥猪流#猫头鹰这么https://www.520it.com 尖叫[偷笑]、@南哥: 老鼠这么[吃惊]、@江哥: 莫名奇#小笼包#妙的笑到最后[嘻嘻]！~ http://t.cn/zYBuKZ8"
        
        // 生成完整的属性字符串
        let strM = NSMutableAttributedString(string: str)
        do{
            // 1.创建规则
            let pattern = "\\[.*?\\]"
            
            // 2.创建正则表达式对象
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpressionOptions.CaseInsensitive)
            // 3.开始匹配
            let res = regex.matchesInString(str, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, str.characters.count))
            // 4取出结果
            /*
            // 有问题: 正向替换会修改字符串的长度, 会影响后面字符串的range
            for checkingRes in res
            {
            // 1.拿到匹配到的表情字符串
            let tempStr = (str as NSString).substringWithRange(checkingRes.range)
            print(tempStr)
            // 2.根据表情字符串查找对应的表情模型
            if let emoticon = emoticonWithStr(tempStr)
            {
            // 3.根据表情模型生成属性字符串
            let attrStr = EmoticonTextAttachment.imageText(emoticon, font: UIFont.systemFontOfSize(18))
            // 4.添加属性字符串
            strM.replaceCharactersInRange(checkingRes.range, withAttributedString: attrStr)
            }
            
            }
            */
            var count = res.count
            while count > 0
            {
                // 0.从后面开始取
                let checkingRes = res[--count]
                
                // 1.拿到匹配到的表情字符串
                let tempStr = (str as NSString).substringWithRange(checkingRes.range)
                //                print(tempStr)
                // 2.根据表情字符串查找对应的表情模型
                if let emoticon = emoticonWithStr(tempStr)
                {
                    print(emoticon.chs)
                    // 3.根据表情模型生成属性字符串
                    let attrStr = EmoticonTextAttachment.imageText(emoticon, font: UIFont.systemFontOfSize(18))
                    // 4.添加属性字符串
                    strM.replaceCharactersInRange(checkingRes.range, withAttributedString: attrStr)
                }
                
                
            }
            
            // 拿到替换之后的属性字符串
            customLabel.attributedText = strM
        }catch
        {
            print(error)
        }
    }
    /**
     根据表情文字找到对应的表情模型
     
     :param: str 表情文字
     
     :returns: 表情模型
     */
    func emoticonWithStr(str: String) -> Emoticon?
    {
        var emoticon: Emoticon?
        for package in EmoticonPackage.packageList
        {
            emoticon = package.emoticons?.filter({ (e) -> Bool in
                return e.chs == str
            }).last
            
            if emoticon != nil{
                break
            }
        }
        return emoticon
    }
    
    */
    
}
