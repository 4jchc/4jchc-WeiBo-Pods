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
    添加案例
    1.创建数据库对象FMDatabase
    db = FMDatabase(path: path)
    2.结果集FMResultSet
    let res = SQLiteManager.shareManager().db!.executeQuery(sql, withArgumentsInArray: nil)
    while res.next()
    */