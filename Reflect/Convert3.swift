//
//  Convert3.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation



/**  属性值为数组的转换  */
class Person3: Reflect {
    
    var name: String!
    
    var score: [Int]!
    
    var bags: [Bag]!
    
    class func convert(){
        
        let person3 = Person3()
        person3.name = "jack"
        person3.score = [98,87,95]
        
        let bag1 = Bag(color: "red", price: 12)
        let bag2 = Bag(color: "blue", price: 15.8)
        
        person3.bags = [bag1,bag2]
        
        let dict = person3.toDict()
        
        print(dict)
    }
}


