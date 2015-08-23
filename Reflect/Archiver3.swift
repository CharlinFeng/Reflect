//
//  Archiver3.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation


/**  主要测试数组的归档  */
class Book3: Reflect{
    
    var name: String!
    
    var price: NSNumber!
    

    
    
    class func action(){
        
        let b1 = Book3()
        b1.name = "name1"
        b1.price = 18.0
        
        let b2 = Book3()
        b2.name = "name2"
        b2.price = 25.5
        
        let b3 = Book3()
        b3.name = "name3"
        b3.price = 17.9
        
        let bookArr = [b1,b2,b3]
        
        let path =  Book3.save(obj: bookArr, name: "book3")
        
        println(path)

        let arr = Book3.read(name: "book3")
        
        
        
    }
    
}