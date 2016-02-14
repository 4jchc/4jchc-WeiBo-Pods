//
//  ViewController.swift
//  WeiBo-FMDB
//
//  Created by 蒋进 on 16/2/14.
//  Copyright © 2016年 蒋进. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        let p = Person(dict: ["name": "zs", "age": 38])
        print(p.insertPerson())
        print(Person.loadPersons())
    }


}

