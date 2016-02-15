//
//  StatusDAO.swift
//  4jchc-WeiBo-Pods
//
//  Created by 蒋进 on 16/2/15.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

/// 数据访问层
class StatusDAO: NSObject {
    
    class  func loadStatuses() {
        // 1.从本地数据库中获取
        // 2.如果本地有, 直接返回
        // 3.从网络获取
        // 4.将从网络获取的数据缓存起来
    }
    
    /// 缓存微博数据
    class func cacheStatuses(statuses: [[String: AnyObject]])
    {
        
        // 0. 准备数据
        let userId = UserAccount.loadAccount()!.uid!
        
        // 1.定义SQL语句
        let sql = "INSERT INTO T_Status" +
            "(statusId, statusText, userId)" +
            "VALUES" +
        "(?, ?, ?);"
        
        // 2.执行SQL语句
        SQLiteManager.shareManager().dbQueue?.inTransaction({ (db, rollback) -> Void in
            
            for dict in statuses
            {
                let statusId = dict["id"]!
                // JSON -> 二进制 -> 字符串
                let data = try! NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.PrettyPrinted)
                let statusText = String(data: data, encoding: NSUTF8StringEncoding)!
                print(statusText)
                if !db.executeUpdate(sql, statusId, statusText, userId)
                {
                    // 如果插入数据失败, 就回滚
                    rollback.memory = true
                }
                
            }
        })
    }
}
