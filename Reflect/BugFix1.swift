//
//  BugFix1.swift
//  Reflect
//
//  Created by 冯成林 on 16/1/28.
//  Copyright © 2016年 冯成林. All rights reserved.
//

import Foundation

let UserDict = ["name": "jack", "age": "28", "img_model": ["url":"http://host.com/1.jpg"]]

class ImageModel: Reflect {

    var url: String!
}


class UserModel: Reflect {
    
    var name: String!
    var age: NSNumber!
    
    var img_model: ImageModel?
    
    class func parse(){
    
        let user = UserModel.parse(dict: UserDict)
        
        print("解析成功：\(user)")
    }
}







