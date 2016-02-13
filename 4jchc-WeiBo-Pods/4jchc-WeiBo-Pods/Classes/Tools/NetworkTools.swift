//
//  NetworkTools.swift
//  4jchc-WeiBo-Pods
//
//  Created by 蒋进 on 16/1/31.
//  Copyright © 2016年 蒋进. All rights reserved.
//


//MARK: - AFNetworking
import UIKit
import AFNetworking

class NetworkTools: AFHTTPSessionManager {
    
    static let tools:NetworkTools = {
        // 注意: baseURL一定要以/结尾
        let url = NSURL(string: "https://api.weibo.com/")
        let t = NetworkTools(baseURL: url)
        
        // 设置AFN能够接收得数据类型
        t.responseSerializer.acceptableContentTypes = NSSet(objects: "application/json", "text/json", "text/javascript", "text/plain") as? Set<String>
        return t
    }()
    
    /// 获取单粒的方法
    class func shareNetworkTools() -> NetworkTools {
        return tools
    }

}




