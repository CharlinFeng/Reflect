//
//  test7.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

let Student7DictArr = [

    ["name":"jack1", "age": 28,"age2":1],
    ["name":"jim", "age": 26],
    ["name":"kit", "age": 22]
]



/**  主要测试字典数组转模型数组  */
class Student7: Reflect {
    
    var name: String!
    var age: NSNumber!
    var age2: Bool!
    
    
    /**  bool  */
    override func setValue(_ value: Any?, forUndefinedKey key: String) {

        self.age2 = value as! NSNumber != 0
    }
    
    class func parse(){
        
        let stus = Student7.parses(arr: Student7DictArr as NSArray)
    
        for stu in stus {
            print(stu)
        }
    }
}
