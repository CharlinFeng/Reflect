//
//  Archiver2.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation


/**  主要测试：属性为模型的归档  */
class Book2: Reflect {
    
    var name: String!
    var price: NSNumber!
    
    var writter: Writter!
    
    class func action(){
        
        let book2 = Book2()
        book2.name = "journey"
        book2.price = 35.0
        
        let writter = Writter()
        writter.nick = "tom"
        writter.age = 48
        
        book2.writter = writter
        
//        Book2.save(obj: book2, name: "Book2", duration: 10)
        Book2.deleteReflectModel(name: "Book2")
        let res = Book2.read(name: "Book2")
        
        print(res)
        
    }
    
    
    override func ignoreCodingPropertiesForCoding() -> [String]? {
        return ["price"]
    }
}


class Writter: Reflect {
    
    var nick: String!
    var age: NSNumber!
    
}
















