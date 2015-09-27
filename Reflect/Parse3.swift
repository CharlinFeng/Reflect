//
//  test3.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

let Student3Dict = ["name": "jack", "age": 28, "pens": [["length":5.5],["length":6.5],["length":7.5]],"score": ["88",66,99.5]]


/**  主要完成数组的转换  */
class Student3: Reflect {
    
    var name: String
    var age: NSNumber
    var pens: [Pen]
    var score: [Int]
    required init() {
        
        name = ""
        age = 0
        pens = []
        score = []
    }
    
    class func parse(){
        
        let stu3 = Student3.parse(dict: Student3Dict)

        print(stu3)

    }
    
    class Pen: Reflect {
        
        var length: NSNumber
        
        required init() {
            length = 0
        }
    }
    
}


