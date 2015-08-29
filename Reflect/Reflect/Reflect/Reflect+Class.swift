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
func ClassFromString(var str: String) -> AnyClass!{
    
    if  var appName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as? String {
        
        if appName == "" {appName = (NSBundle.mainBundle().bundleIdentifier!.explode(".")).last ?? ""}
        
        if !str.contain("\(appName).") { print("您传的字符串格式不正确，请包含命名空间。");return nil}

        let strArr = str.explode(".")
        
        var className = ""
        
        let num = strArr.count
        
        if num <= 2 {
            
            className = str
            
        }else if num == 3{
           
            var nameStringM = "_TtCC"
            
            /** 数组遍历 */
            for str in strArr {
                nameStringM += "\(str.characters.count)\(str)"
            }
            
            className = nameStringM

        }else{
            
            print("命名空间层次过深，暂不支持")
            return nil
        }
        
        return NSClassFromString(className)
    }
    
    return nil;
}

