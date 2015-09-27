//
//  Person.swift
//  Reflect
//
//  Created by 冯成林 on 15/8/19.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit

class Person: Reflect {

    var name: String
    var age: Int
    
    var v1: String?
    var v2: String!
    var v3: Int?
    var v4: Int!
    var v5: Float
    var v6: Double
    var v7: NSNumber
    var v8: UIImage
    var v9: NSData!
    var v10: Bool
    var v11: Bool?
    var v12: Bool!
    var v13: NSArray
    var v14: [String]
    var v15: [String]?
    var v16: [String]!
    var v17: [Person?]
    var v18: [Person]?
    var v19: [Person]!
    

    
    required init(){
        name = ""
        age = 0
        v5 = 0
        v6=0
        v7=0
        v8 = UIImage()
        v9=NSData()
        v10 = false
        v13 = NSArray()
        v14 = []
        v17 = []
    }

    class func reflect(){
        
        self.properties { (name, type, value) -> Void in
            print("\(name): \(type.isReflect), \(type.typeName)")
        }
        
    }
    
}
