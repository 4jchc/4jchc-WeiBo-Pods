//
//  EmoticonPackage.swift
//  WeiBo表情键盘
//
//  Created by 蒋进 on 16/2/11.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
    /*
    结构:
    1. 加载emoticons.plist拿到每组表情的路径

    emoticons.plist(字典)  存储了所有组表情的数据
    |----packages(字典数组)
    |-------id(存储了对应组表情对应的文件夹)

    2. 根据拿到的路径加载对应组表情的info.plist
    info.plist(字典)
    |----id(当前组表情文件夹的名称)
    |----group_name_cn(组的名称)
    |----emoticons(字典数组, 里面存储了所有表情)
    |----chs(表情对应的文字)
    |----png(表情对应的图片)
    |----code(emoji表情对应的十六进制字符串)
    */
class EmoticonPackage: NSObject {
    /// 当前组表情文件夹的名称
    var id: String?
    /// 组的名称
    var group_name_cn : String?
    /// 当前组所有的表情对象
    var emoticons: [Emoticon]?
    
    /// 获取所有组的表情数组
    // 浪小花 -> 一组  -> 所有的表情模型(emoticons)
    // 默认 -> 一组  -> 所有的表情模型(emoticons)
    // emoji -> 一组  -> 所有的表情模型(emoticons)
    class func loadPackages() -> [EmoticonPackage]? {
        let path = NSBundle.mainBundle().pathForResource("emoticons.plist", ofType: nil, inDirectory: "Emoticons.bundle")!
        // 1.加载emoticons.plist
        let dict = NSDictionary(contentsOfFile: path)!
        // 2.或emoticons中获取packages
        let dictArray = dict["packages"] as! [[String:AnyObject]]
        // 3.遍历packages数组
        var packages = [EmoticonPackage]()
        for d in dictArray
        {
            // 4.取出ID, 创建对应的组
            let package = EmoticonPackage(id: d["id"]! as! String)
            packages.append(package)
            package.loadEmoticons()
        }
        return packages
    }
    
    /// 加载每一组中所有的表情
    func loadEmoticons() {
        let emoticonDict = NSDictionary(contentsOfFile: infoPath())!
        group_name_cn = emoticonDict["group_name_cn"] as? String
        let dictArray = emoticonDict["emoticons"] as! [[String: String]]
        emoticons = [Emoticon]()
        for dict in dictArray{
            // 添加模型
            emoticons?.append(Emoticon(dict: dict, id: id!))
        }
    }
    
    /**
     :param: fileName 文件的名称
     
     :returns: 全路径
     */
    //MARK: 获取指定文件的全路径
    func infoPath() -> String {
        return (EmoticonPackage.emoticonPath().stringByAppendingPathComponent(id!) as NSString).stringByAppendingPathComponent("info.plist")
    }
    //MARK: 获取微博表情的主路径
    class func emoticonPath() -> NSString{
        return (NSBundle.mainBundle().bundlePath as NSString).stringByAppendingPathComponent("Emoticons.bundle")
    }
    
    init(id: String)
    {
        self.id = id
    }
}

class Emoticon: NSObject {
    /// 表情对应的文字
    var chs: String?
    /// 表情对应的图片
    var png: String?
    /// emoji表情对应的十六进制字符串
    var code: String?
    /// 当前表情对应的文件夹
    var id: String?
    
    init(dict: [String: String], id: String)
    {
        super.init()
        self.id = id
        setValuesForKeysWithDictionary(dict)
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
}
