//
//  Student.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit


let Student1Dict = ["name": "jack", "age": "28", "age2": 28,"v1": 98.5, "v2": 568.32414,"isVip":"1"]

/**  基本测试: 最常见类型的转换  */
class Student1: Reflect {
   
    var name: String
    
    var age: NSNumber
    
    var age2: NSNumber
    
    var v1: NSNumber
    var v2: NSNumber
    
    var isVip: Bool
    
    required init(){
        
        self.name = ""
        self.age = 0
        self.age2 = 0
        self.v1 = 0
        self.v2 = 0
        
        isVip = false
    }
    
    class func parse(){
        
        let stu1 = Student1.parse(dict: Student1Dict)
        
        print(stu1)
    }
    
    override func parseOver() {
        print("转换结束")
    }
}
