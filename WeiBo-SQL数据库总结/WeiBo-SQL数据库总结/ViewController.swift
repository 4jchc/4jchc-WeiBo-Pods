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
        /*
        let start = CFAbsoluteTimeGetCurrent()
        for i in 0..<10000
        {
        let p = Person(dict: ["name": "zs + \(i)", "age": 3 + i])
        p.insertPerson()
        }
        
        print("耗时 = \(CFAbsoluteTimeGetCurrent() - start)")
        */

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

