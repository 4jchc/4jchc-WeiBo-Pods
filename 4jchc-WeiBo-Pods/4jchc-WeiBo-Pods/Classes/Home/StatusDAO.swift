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
    
    //MARK:  从数据库FMDB中加载缓存数据
    ///  从数据库FMDB中加载缓存数据
    class func loadCacheStatuses(since_id: Int, max_id: Int, finished: ([[String: AnyObject]])->()) {
        
        // 1.定义SQL语句
        var sql = "SELECT * FROM T_Status \n"
        if since_id > 0
        {
            sql += "WHERE statusId > \(since_id) \n"
        }else if max_id > 0
        {
            sql += "WHERE statusId <= \(since_id) \n"
        }
        
        sql += "ORDER BY statusId DESC \n"
        sql += "LIMIT 20; \n"
        
        // 2.执行SQL语句
        SQLiteManager.shareManager().dbQueue?.inDatabase({ (db) -> Void in
            
            // 2.1查询数据--FMResultSet
            let res =  db.executeQuery(sql, withArgumentsInArray: nil)
            
            // 2.2遍历取出查询到的数据
            // 返回字典数组的原因:通过网络获取返回的也是字典数组,
            // 让本地和网络返回的数据类型保持一致, 以便于我们后期处理
            var statuses = [[String: AnyObject]]()
            while res.next()
            {
                // 1.取出数据库存储的一条微博字符串
                let dictStr = res.stringForColumn("statusText") as String
                // 2.将微博字符串转换为微博字典
                // string->data->dict
                let data = dictStr.dataUsingEncoding(NSUTF8StringEncoding)!
                let dict = try! NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [String: AnyObject]
                statuses.append(dict)
            }
            
            // 3.返回数据
            finished(statuses)
        })
    }

    //MARK:   缓存微博数据
    ///   缓存微博数据
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
