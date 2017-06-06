//
//  Test2.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit
import Foundation

let Student2Dict = ["name": "jack", "age": 28, "bag": ["color": "blue", "price": 14.5]] as [String : Any]


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
        
        let stu2 = Student2.parse(dict: Student2Dict as NSDictionary)
    
        print("\(stu2)")
    }
}

class Bag: Reflect {
    
    var color: String
    
    var price: NSNumber
    
    required init(){
        color = ""
        price = 0
    }
    
    init (color: String, price: Float){
        
        self.color = color
        
        self.price = NSNumber(floatLiteral: Double(price))
    }
}


