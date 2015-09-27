//
//  Reflect+Class.swift
//  Reflect
//
//  Created by 冯成林 on 15/8/19.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

extension Reflect{
    
    /** 类名字符串：含命名空间 */
    static var classNameOfString: String {return "\(self)"}
}

/** 此功能复杂需要长期研讨，本次暂支持致此 */
func ClassFromString(str: String) -> AnyClass!{
    //_TtCC7Reflect4User3Fav
    if  var appName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as? String {
        
        if appName == "" {appName = ((NSBundle.mainBundle().bundleIdentifier!).characters.split{$0 == "."}.map { String($0) }).last ?? ""}
        
        var clsStr = str
        
        if !str.contain(subStr: "\(appName)."){
            clsStr = appName + "." + str
        }

        let strArr = clsStr.explode(".")
        
        var className = ""
        
        let num = strArr.count
        
        if num <= 2 {
            
            className = clsStr
            
        }else if num > 3{
           
            var nameStringM = "_TtC" + "C".repeatTimes(num - 2)
            
            /** 数组遍历 */
            for (_, s): (Int, String) in strArr.enumerate(){
                
                nameStringM += "\(s.characters.count)\(s)"
            }
            
            className = nameStringM
        }
        
        return NSClassFromString(className)
    }
    
    return nil;
}

