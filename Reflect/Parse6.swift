//
//  test6.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

let Student6Dict = ["name": "jack", "age": 28,"items1": ["a1","b1","c1"],"items2": ["a2","b2","c2"],"bags": [["color": "red","price": 12.5],["color": "blue","price": 15]]]


/**  主要测试：显式可选 */
class Student6: Reflect {
    
    var name: String?
    var age: NSNumber?
    
    var items1: [String]?
//    var items2: [String!]!
    var bags: [Bag]?
    
    class func parse(){
        
        let stu6 = Student6.parse(dict: Student6Dict)
        
        print(stu6)
    }
}