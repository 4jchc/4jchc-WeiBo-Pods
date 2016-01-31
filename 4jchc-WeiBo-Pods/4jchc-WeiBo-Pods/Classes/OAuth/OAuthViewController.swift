//
//  OAuthViewController.swift
//  4jchc-WeiBo-Pods
//
//  Created by 蒋进 on 16/1/31.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class OAuthViewController: UIViewController {
    
    let WB_App_Key = "1620692692"
    let WB_App_Secret = "07f24cb123c91647e01b347eca27a5f7"
    let WB_redirect_uri = "http://www.baidu.com/"//没有/无法显示登录页面
    //4c55e50bb30c37cafd96405ebc028c8e&from=844b&vit=fps
    ///https://api.weibo.com/oauth2/authorize?client_id=1620692692&redirect_uri=http://www.baidu.com/
    
    override func loadView() {
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 0.初始化导航条
        navigationItem.title = "4jchc微博"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "关闭", style: UIBarButtonItemStyle.Plain, target: self, action: "close")
        
        // 1.获取未授权的RequestToken
        // 要求SSL1.2
        let urlStr = "https://api.weibo.com/oauth2/authorize?client_id=\(WB_App_Key)&redirect_uri=\(WB_redirect_uri)"
        let url = NSURL(string: urlStr)
        let request = NSURLRequest(URL: url!)
        webView.loadRequest(request)
    }
    
    func close()
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - 懒加载
    private lazy var webView: UIWebView = {
        let wv = UIWebView()
        wv.delegate = self
        return wv
    }()
    

}


extension OAuthViewController: UIWebViewDelegate
{
    // 返回ture正常加载 , 返回false不加载
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool
    {
        /*
        加载授权界面: https://api.weibo.com/oauth2/authorize?client_id=2624860832&redirect_uri=http://www.baidu.com/
        
        跳转到授权界面: https://api.weibo.com/oauth2/authorize
        
        
        
        授权成功: http://www.baidu.com//?code=91e779d15aa73698cbbb72bc7452f3b3
        
        取消授权: http://www.baidu.com//?error_uri=%2Foauth2%2Fauthorize&error=access_denied&error_description=user%20denied%20your%20request.&error_code=21330
        */
        print("request.URL?.absoluteString----\(request.URL?.absoluteString)")
        
        // 1.判断是否是授权回调页面, 如果不是就继续加载
        let urlStr = request.URL!.absoluteString
        if !urlStr.hasPrefix(WB_redirect_uri)
        {
            // 继续加载网页
            return true
        }
        
        // 2.判断是否授权成功
        let codeStr = "code="
        if request.URL!.query!.hasPrefix(codeStr)
        {
            // 授权成功
            print("授权成功")
            // 取出已经授权的RequestToken
            // codeStr.endIndex是拿到code=最后的位置
            let code = request.URL!.query?.substringFromIndex(codeStr.endIndex)
            print(code)
        }else
        {
            // 取消授权
            print("取消授权")
            // 关闭界面
            close()
        }
        
        return false
    }
}





