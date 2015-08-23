//
//  Cconvert2.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation


/**  含有子模型转换  */

class Person2: Reflect{
    
    var name: String!
    var age: NSNumber!
    var life: Life!
    
    
    class func convert(){
        
        let life = Life()
        life.length = 100
        
        let person2 = Person2()
        person2.name = "jack"
        person2.age = 28
        person2.life = life
        
        let dict = person2.toDict()
        
        println(dict)
    }
}


class Life: Reflect {
    var length: NSNumber!
}