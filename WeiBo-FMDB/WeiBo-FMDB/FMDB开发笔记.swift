//
//  FMDB开发笔记.swift
//  WeiBo-FMDB
//
//  Created by 蒋进 on 16/2/14.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit


    /*
    添加FMDB-动态库sql-桥接
    */

    /*
    添加案例--FMDatabase
    1.创建数据库对象FMDatabase
    db = FMDatabase(path: path)
    2.结果集FMResultSet
    let res = SQLiteManager.shareManager().db!.executeQuery(sql, withArgumentsInArray: nil)
    while res.next()
    */

    /*
    FMDatabase多线程是不安全的
    添加案例--FMDatabaseQueue--inDatabase线程是安全的
    0. 查询---executeQuery执行SQL语句-inDatabase
     SQLiteManager.shareManager().dbQueue?.inDatabase({ (db) -> Void in
     let res = db.executeQuery(sql, withArgumentsInArray: nil)

    1. 创表---执行SQL语句-inDatabase
     dbQueue!.inDatabase { (db) -> Void in
     db.executeUpdate(sql, withArgumentsInArray: nil)
    }

    2. 插入---只要在inTransaction闭包中执行的语句都是已经开启事务的
     第一个参数: db 已经打开的数据库对象
     第二个参数: rollback 用于设置是否需要回滚数据
     SQLiteManager.shareManager().dbQueue?.inTransaction({ (db, rollback) -> Void in
     if !db.executeUpdate(sql, withArgumentsInArray: nil)
     如果插入数据失败, 就回滚
     OC中的写法 : *rollback = YES;
     Swift中的写法: rollback.memory = true
    3.闭包传值的使用.外界调用需要参数.内部要定义一个闭包来保存获得的值让外界调用此闭包
    */




