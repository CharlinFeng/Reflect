//
//  Archiver1.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

/**  主要测试归档: 基本测试  */
class Book1: Reflect {
    
    var name: String
    var price: NSNumber
    
    init(name: String, price: NSNumber){
        
        self.name = name
        self.price = price
    }

    required init() {
        
        name = ""
        price = 0
    }
    
    class func action(){
        
        let book1 = Book1(name: "tvb", price: 36.6)

        
        if Book1.read(name: "book1") == nil {
            
            //无缓存或缓存过期
            print("无缓存或缓存过期")
            
            Book1.save(obj: book1, name: "book1", duration: 10)
            
        }else {
            
            print("有缓存")
        }
        
    }
    
    
}



