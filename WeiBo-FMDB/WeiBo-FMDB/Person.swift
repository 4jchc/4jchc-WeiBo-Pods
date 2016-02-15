
//
//  Person.swift
//  WeiBo-FMDB
//
//  Created by 蒋进 on 16/2/14.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class Person: NSObject {
    var id: Int = 0
    var age: Int = 0
    var name: String?
    
    
    // MARK: - FMDatabaseQueue执行数据源CRUD的操作
    class func loadPersons(finished: ([Person])->())
    {
        let sql = "SELECT * FROM T_Person;"
        
        
        SQLiteManager.shareManager().dbQueue?.inDatabase({ (db) -> Void in
            
            let res = db.executeQuery(sql, withArgumentsInArray: nil)
            
            // next取出一行数据
            var models = [Person]()
            while res.next()
            {
                let p = Person()
                let num = res.intForColumn("id")
                let name = res.stringForColumn("name")
                let age = res.intForColumn("age")
                print("num = \(num), name = \(name), age = \(age)")
                
                p.id = Int(num)
                p.name = name
                p.age = Int(age)
                models.append(p)
            }
            
            finished(models)
        })
        
    }
    
    
    /**
     插入一条记录
     */
    func insertPerson()
    {
        
        assert(name != nil, "必须要给name赋值")
        
        // 1.编写SQL语句
        let sql = "INSERT INTO T_Person" +
            "(name, age)" +
            "VALUES" +
        "('\(name)', \(age));"
        
        // 2.执行SQL语句
        // 只要在inTransaction闭包中执行的语句都是已经开启事务的
        /*
        第一个参数: 已经打开的数据库对象
        第二个参数: 用于设置是否需要回滚数据
        */
        SQLiteManager.shareManager().dbQueue?.inTransaction({ (db, rollback) -> Void in
            if !db.executeUpdate(sql, withArgumentsInArray: nil)
            {
                // 如果插入数据失败, 就回滚
                // OC中的写法 : *rollback = YES;
                // Swift中的写法: rollback.memory = true
                rollback.memory = true
            }
        })
    }
    
    
    
    
    
    
    
    
    /*
    // MARK: - FMDatabase执行数据源CRUD的操作
    class func loadPersons() -> [Person]
    {
        let sql = "SELECT * FROM T_Person;"
        let res = SQLiteManager.shareManager().db!.executeQuery(sql, withArgumentsInArray: nil)
        
        var models = [Person]()
        // next取出一行数据
        while res.next()
        {
            let p = Person()
            let num = res.intForColumn("id")
            let name = res.stringForColumn("name")
            let age = res.intForColumn("age")
            //            print("num = \(num), name = \(name), age = \(age)")
            p.id = Int(num)
            p.name = name
            p.age = Int(age)
            models.append(p)
        }
        return models
    }
    
    
    /**
     插入一条记录
     */
    func insertPerson() -> Bool
    {
        
        assert(name != nil, "必须要给name赋值")
        
        // 1.编写SQL语句
        let sql = "INSERT INTO T_Person" +
            "(name, age)" +
            "VALUES" +
        "(?, ?);"
        
        // 2.执行SQL语句
        //        return SQLiteManager.shareManager().db!.executeUpdate(sql, withArgumentsInArray: nil)
        
        return SQLiteManager.shareManager().db!.executeUpdate(sql, name!, age)
    }
    
    */
    
    // MARK: - 系统内部方法
    init(dict: [String: AnyObject])
    {
        super.init()
        setValuesForKeysWithDictionary(dict)
    }
    
    override init()
    {
        super.init()
    }
    
    override func setValue(value: AnyObject?, forUndefinedKey key: String) {
        
    }
    
    override var description: String
        {
            return "id = \(id), age = \(age), name = \(name)"
    }
}