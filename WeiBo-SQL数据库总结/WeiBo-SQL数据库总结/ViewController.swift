//
//  ViewController.swift
//  WeiBo-SQL数据库总结
//
//  Created by 蒋进 on 16/2/14.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let p = Person(dict: ["name": "zs", "age": 3])
        //        print(p.insertPerson())
        //        print(p.updatePerson("ww"))
        //        print(p.deletePerson())
        //        let models = Person.loadPersons()
        //        print(models)
        p.insertQueuePerson()
        
        insertPersonTransaction()
        prepareInsertPersonTransaction()
    }
    
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        prepareInsertPersonTransaction()
    }
    
    
    func prepareInsertPersonTransaction(){
        
        let start = CFAbsoluteTimeGetCurrent()
        let manager = SQLiteManager.shareManager()
        // 开启事务
        manager.beginTransaction()
        for i in 0..<10000
        {
            let sql = "INSERT INTO T_Person" +
                "(name, age)" +
                "VALUES" +
            "(?, ?);"
            
            manager.batchExecSQL(sql, args: "yy +\(i)", 1 + i)
        }
        // 提交事务
        manager.commitTransaction()
        print("耗时prepareInsertPersonTransaction = \(CFAbsoluteTimeGetCurrent() - start)")
    }
    
    
    func insertPersonTransaction(){
        
        let start = CFAbsoluteTimeGetCurrent()
        let manager = SQLiteManager.shareManager()
        
        //MARK:  开启事务
        manager.beginTransaction()
        
        for i in 0..<10000
        {
            let p = Person(dict: ["name": "zs + \(i)", "age": 3 + i])
            p.insertPerson()
            
//            if i == 1000
//            {
//                manager.rollbackTransaction()
//                // 注意点: 回滚之后一定要跳出循环停止更新
//                break
//            }
            
            
        }
        
        // 提交事务
        manager.commitTransaction()
        
        print("耗时insertPersonTransaction = \(CFAbsoluteTimeGetCurrent() - start)")
    }





}

