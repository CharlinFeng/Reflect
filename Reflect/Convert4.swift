//
//  Convert4.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation


/**  主要测试显示可选  */


class Person4: Reflect {
    
    var name: String?
    var age: Int?
    
    
    
    class func convert(){
        
        let person4 = Person4()
        
        person4.name = "jack"
        person4.age = 28
        
        let dict = person4.toDict()
        
        print(dict)
    }
    
}