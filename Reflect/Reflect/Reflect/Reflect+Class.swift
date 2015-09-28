//
//  Reflect+Class.swift
//  Reflect
//
//  Created by 冯成林 on 15/8/19.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

extension Reflect{static var classNameOfString: String {return "\(self)"}}

func ClassFromString(str: String) -> AnyClass!{

    if  var appName = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as? String {
        
        if appName == "" {appName = ((NSBundle.mainBundle().bundleIdentifier!).characters.split{$0 == "."}.map { String($0) }).last ?? ""}
        
        var clsStr = str
        
        if !str.contain(subStr: "\(appName)."){
            clsStr = appName + "." + str
        }

        let strArr = clsStr.explode(".")
        
        var className = ""
        
        let num = strArr.count
        
        if num > 2 || strArr.contains(appName) {
            
            var nameStringM = "_TtC" + "C".repeatTimes(num - 2)
            
            for (_, s): (Int, String) in strArr.enumerate(){
                
                nameStringM += "\(s.characters.count)\(s)"
            }
            
            className = nameStringM
            
        }else{
           
            className = clsStr
        }
        
        return NSClassFromString(className)
    }
    
    return nil;
}

