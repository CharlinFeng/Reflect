//
//  test8.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation


class Author: Reflect {
    
    var name: String!
    var age: NSNumber!
    var sex: String!
    
    class func parse(){
        
        let author = Author.parsePlist(name: "Author")
        print(author)
        
    }
}
