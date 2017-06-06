//
//  test4.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

let Student4Dict = ["id":1, "name": "jack", "age": 26,"func": "zoom"] as [String : Any]

/**  主要测试以下功能  */
// 模型中有多余的key
// 字段映射
// 字段忽略
class Student4: Reflect {
    
    var hostID: Int
    var name:String
    var age: Int
    var hobby: String
    var funcType: String
    
    required init() {
        hostID = 0
        name = ""
        age = 0
        hobby = ""
        funcType = ""
    }
    
    override func mappingDict() -> [String : String]? {
        return ["hostID": "id", "funcType": "func"]
    }
    
    override func ignorePropertiesForParse() -> [String]? {
  
        return ["funcType"]
    }
    
    
    class func parse(){
        
        let stu4 = Student4.parse(dict: Student4Dict as NSDictionary)
        print(stu4)
    }
    
}
