//
//  SQLiteManager.swift
//  WeiBo-FMDB
//
//  Created by 蒋进 on 16/2/14.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class SQLiteManager: NSObject {
    
    private static let manager: SQLiteManager = SQLiteManager()
    /// 单粒
    class func shareManager() -> SQLiteManager {
        return manager
    }
    
    // MARK: - FMDatabaseQueue
    var dbQueue: FMDatabaseQueue?
    
    /**
     *  打开数据库
     */
    func openDB(DBName: String)
    {
        // 1.根据传入的数据库名称拼接数据库路径
        let path = DBName.documentPath()
        print(path)
        
        // 2.创建数据库对象
        // 注意: 如果是使用FMDatabaseQueue创建数据库对象, 那么就不用打开数据库
        dbQueue = FMDatabaseQueue(path: path)
        
        
        // 4.创建表
        creatTable()
    }
    
    private func creatTable()
    {
        // 1.编写SQL语句
        let sql = "CREATE TABLE IF NOT EXISTS T_Status( \n" +
            "statusId INTEGER PRIMARY KEY, \n" +
            "statusText TEXT, \n" +
            "userId INTEGER, \n" +
            "createDate TEXT NOT NULL DEFAULT (datetime('now', 'localtime')) \n" +
        "); \n"
        
        // 2.执行SQL语句
        dbQueue!.inDatabase { (db) -> Void in
            db.executeUpdate(sql, withArgumentsInArray: nil)
        }
    }
    
    
    
    
    // MARK: - FMDatabase
    /*
    
    var db: FMDatabase?
    /**
     *  打开数据库
     */
    func openDB(DBName: String)
    {
        // 1.根据传入的数据库名称拼接数据库路径
        let path = DBName.docDir()
        print(path)
        
        // 2.创建数据库对象
        db = FMDatabase(path: path)
        
        // 3.打开数据库
        // open方法特点: 如果指定路径对应的数据库文件已经存在, 就会直接打开
        //              如果指定路径对应的数据库文件不存在, 就会创建一个新的
        if !db!.open()
        {
            print("打开数据库失败")
            return
        }
        
        // 4.创建表
        creatTable()
    }
    
    private func creatTable()
    {
        // 1.编写SQL语句
        let sql = "CREATE TABLE IF NOT EXISTS T_Person( \n" +
            "id INTEGER PRIMARY KEY AUTOINCREMENT, \n" +
            "name TEXT, \n" +
            "age INTEGER \n" +
        "); \n"
        
        // 2.执行SQL语句
        // 注意点: 在FMDB中除了查询意外, 都称之为更新
        if db!.executeUpdate(sql, withArgumentsInArray: nil)
        {
            print("创建表成功")
        }else
        {
            print("创建表失败")
        }
    }
    */
    
}