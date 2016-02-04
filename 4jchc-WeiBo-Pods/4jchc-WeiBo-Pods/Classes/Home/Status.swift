//
//  Status.swift
//  4jchc-WeiBo-Pods
//
//  Created by 蒋进 on 16/2/4.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class Status: NSObject {
    /// 微博创建时间
    var created_at: String?
    /// 微博ID
    var id: Int = 0
    /// 微博信息内容
    var text: String?
    /// 微博来源
    var source: String?
    /// 配图数组
    var pic_urls: [[String: AnyObject]]?
    
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
            finished(models: models, error: nil)
                
            }) { (_, error) -> Void in
                
                print(error)
                finished(models: nil, error: error)
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
        
        //        print("key = \(key), value = \(value)")
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
