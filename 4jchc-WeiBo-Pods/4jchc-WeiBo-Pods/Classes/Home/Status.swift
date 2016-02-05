//
//  Status.swift
//  4jchc-WeiBo-Pods
//
//  Created by 蒋进 on 16/2/4.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit
import SDWebImage
class Status: NSObject {

    
    /// 微博创建时间
    var created_at: String?{
        
        didSet{
            //            created_at = "Sun Sep 12 14:50:57 +0800 2014"
            
            // 1.将字符串转换为时间
            let createdDate = NSDate.dateWithStr(created_at!)
            // 2.获取格式化之后的时间字符串
            created_at = createdDate.descriptionDate
        }
    }
    
    /// 微博ID
    var id: Int = 0
    /// 微博信息内容
    var text: String?

    /// 微博来源
    var source: String?
        {
        didSet{
            // <a href=\"http://app.weibo.com/t/feed/4fuyNj\" rel=\"nofollow\">即刻笔记</a>
            
            if source == ""{
                return
            }
            
            // 1.截取字符串
            if let str = source{
                
                // 1.1获取开始截取的位置
                let startLocation = (str as NSString).rangeOfString(">").location + 1
                // 1.2获取截取的长度
                let length = (str as NSString).rangeOfString("<", options: NSStringCompareOptions.BackwardsSearch).location - startLocation
                // 1.3截取字符串
                source = "来自:" + (str as NSString).substringWithRange(NSMakeRange(startLocation, length))
            }
        }
    }
    
    
    
    
    /// 配图-数组
    var pic_urls: [[String: AnyObject]]?{
        didSet{
            // 1.初始化数组
            storedPicURLS = [NSURL]()
            // 2遍历取出所有的图片路径字符串
            for dict in pic_urls!
            {
                if let urlStr = dict["thumbnail_pic"]
                {
                    // 将字符串转换为URL保存到数组中
                    storedPicURLS?.append(NSURL(string: urlStr as! String)!)
                }
            }
        }
    }
    //MARK: - 保存当前微博所有配图的URL
    var storedPicURLS: [NSURL]?
    
    
    
    
    
    
    
    /// 用户信息
    var user: User?
    
    /// 加载微博数据
    class func loadStatuses(finished: (models:[Status]?, error:NSError?)->()){
        
        let path = "2/statuses/home_timeline.json"
        let params = ["access_token": UserAccount.loadAccount()!.access_token!]
        NetworkTools.shareNetworkTools().GET(path, parameters: params , progress: { (_) -> Void in
            
            },success: { (_, JSON) -> Void in
            
            // 1.取出statuses key对应的数组 (存储的都是字典)
            // 2.遍历数组, 将字典转换为模型
            let models = dict2Model(JSON!["statuses"] as! [[String: AnyObject]])

            //MARK: - 2.通过闭包将数据传递给调用者
           // finished(models: models, error: nil)
                
            //MARK: - 3.等缓存微博配图完成->通过闭包将数据传递给调用者
            cacheStatusImages(models, finished: finished)

            }) { (_, error) -> Void in
                
                printLog(error)
                finished(models: nil, error: error)
        }
        
    }
    
    //MARK: - 缓存图片GCD创建一个组
    ///  缓存图片GCD创建一个组
    class func cacheStatusImages(list: [Status], finished: (models:[Status]?, error:NSError?)->()) {
        
        // 1.创建一个组
        let group = dispatch_group_create()
        
        // 1.缓存图片
        for status in list {
            
            for url in status.storedPicURLS!{
                
                // 将当前的下载操作添加到组中
                dispatch_group_enter(group)
                
                // 缓存图片
                SDWebImageManager.sharedManager().downloadImageWithURL(url, options: SDWebImageOptions(rawValue: 0), progress: nil, completed: { (_, _, _, _, _) -> Void in
                    
                    // 离开当前组
                    dispatch_group_leave(group)
                    printLog("OK")
             
                })
            }
        }
        
        // 2.当所有图片都下载完毕再通过闭包通知调用者
        dispatch_group_notify(group, dispatch_get_main_queue()) { () -> Void in
            //printLog("Over")
            // 能够来到这个地方, 一定是所有图片都下载完毕
            finished(models: list, error: nil)
        }
    }

    
    
    /// 将字典数组转换为模型数组
    class func dict2Model(list: [[String: AnyObject]]) -> [Status] {
        var models = [Status]()
        for dict in list
        {
            models.append(Status(dict: dict))
        }
        return models
    }
    
    // 字典转模型
    init(dict: [String: AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    //MARK:KVC找不到的key要重写这个方法
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    //MARK: - KVC-setValuesForKeysWithDictionary内部会调用以下方法
    override func setValue(value: AnyObject?, forKey key: String) {
        
        //        printLog("key = \(key), value = \(value)")
        // 1.判断当前是否正在给微博字典中的user字典赋值
        if "user" == key
        {
            // 2.根据user key对应的字典创建一个模型
            user = User(dict: value as! [String : AnyObject])
            return
        }
        
        // 3,调用父类方法, 按照系统默认处理
        super.setValue(value, forKey: key)
    }
    
    
    
    // 打印当前模型
    var properties = ["created_at", "id", "text", "source", "pic_urls"]
    override var description: String {
        let dict = dictionaryWithValuesForKeys(properties)
        return "\(dict)"
    }
    
    
    
    
}
