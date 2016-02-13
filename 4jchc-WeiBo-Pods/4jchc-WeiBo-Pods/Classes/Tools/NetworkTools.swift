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
    
    
    /**
     发送微博
     
     :param: text            需要发送的正文
     :param: image           需要发送的图片
     :param: successCallback 成功的回调
     :param: errorCallback   失败的回调
     */
     //MARK:  发送微博
     ///  发送微博
    func sendStatus(text: String, image: UIImage?, successCallback: (status: Status)->(), errorCallback: (error: NSError)->())
    {
        var path = "2/statuses/"
        let params = ["access_token":UserAccount.loadAccount()!.access_token! , "status": text]
        if image != nil
        {
            // 发送图片微博
            path += "upload.json"
            POST(path, parameters: params, constructingBodyWithBlock: { (formData) -> Void in
                // 1.将数据转换为二进制
                let data = UIImagePNGRepresentation(image!)!
                
                // 2.上传数据
                /*
                第一个参数: 需要上传的二进制数据
                第二个参数: 服务端对应哪个的字段名称
                第三个参数: 文件的名称(在大部分服务器上可以随便写)
                第四个参数: 数据类型, 通用类型application/octet-stream
                */
                formData.appendPartWithFileData(data
                    , name:"pic", fileName:"abc.png", mimeType:"application/octet-stream");
                
                },progress: { (progress) -> Void in} ,success: { (_, JSON) -> Void in
                    
                    successCallback(status: Status(dict: JSON as! [String : AnyObject]))
                    
                }, failure: { (_, error) -> Void in
                    
                    errorCallback(error: error)
            })
        }else
        {
            // 发送文字微博
            path += "update.json"
            POST(path, parameters: params,progress: { (progress) -> Void in} , success: { (_, JSON) -> Void in
                successCallback(status: Status(dict: JSON as! [String : AnyObject]))
                }) { (_, error) -> Void in
                    errorCallback(error: error)
            }
        }
        
    }
}




