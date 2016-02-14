
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
    
    
    // MARK: - 执行数据源CRUD的操作
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