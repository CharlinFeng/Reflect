//
//  test9.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation


/**  基本转换  */

class Person1: Reflect {
    
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        
        self.name = name
        self.age = age
    }

    required init() {
        name = ""
        age = 0
    }
    
    
    class func convert(){
        
        let person1 = Person1(name: "jack", age: 28)
        
        let dict = person1.toDict()
        
        print(dict)
        
    }
}