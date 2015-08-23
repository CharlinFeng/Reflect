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
    var price: Float
    
    init(name: String, price: Float){
        
        self.name = name
        self.price = price
    }

    required init() {
        
        name = ""
        price = 0
    }
    
    class func action(){
        
        let book1 = Book1(name: "tvb", price: 36.6)

        Book1.delete(name: nil)
        println(book1)
        
    }
    
    
}



