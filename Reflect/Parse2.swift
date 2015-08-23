//
//  Test2.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit


let Student2Dict = ["name": "jack", "age": 28, "bag": ["color": "blue", "price": 14.5]]


/**  在test1的基础上增加自定义对象  */
class Student2: Reflect {
   
    var name: String
    var age: NSNumber
    
    var bag: Bag

    required init(){
        name = ""
        age = 0
        bag = Bag()
    }
    
    class func parse(){
        
        let stu2 = Student2.parse(dict: Student2Dict)
    
        println("\(stu2) \n \(stu2.bag.color),\(stu2.bag.price)")
    }
}

class Bag: Reflect {
    
    var color: String
    
    var price: Float
    
    required init(){
        color = ""
        price = 0
    }
    
    init (color: String, price: Float){
        
        self.color = color
        self.price = price
    }
}


