//
//  Reflect+Common.swift
//  Reflect
//
//  Created by 冯成林 on 15/8/19.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation



extension Reflect {
    
    override var description: String {
    
        let pointAddr = NSString(format: "%p",unsafeBitCast(self, Int.self)) as String
        
        var printStr = self.classNameString + " <\(pointAddr)>: " + "\r{"
        
        self.properties { (name, type, value) -> Void in
            
            if type.isArray {
                
                printStr += "\r\r['\(name)']: \(value)"
                
            }else{
                
                printStr += "\r\(name): \(value)"
            }
        }
    
        printStr += "\r}"
        
        return printStr
    }
}



extension String{
    
    func contain(subStr subStr: String) -> Bool {return (self as NSString).rangeOfString(subStr).length > 0}
    
    func explode (separator: Character) -> [String] {
        return self.characters.split(isSeparator: { (element: Character) -> Bool in
            return element == separator
        }).map { String($0) }
    }
    
    func replacingOccurrencesOfString(target: String, withString: String) -> String{
        return (self as NSString).stringByReplacingOccurrencesOfString(target, withString: withString)
    }
    
    func deleteSpecialStr()->String{
    
        return self.replacingOccurrencesOfString("Optional<", withString: "").replacingOccurrencesOfString(">", withString: "")
    }
    
    var floatValue: Float? {return NSNumberFormatter().numberFromString(self)?.floatValue}
    var doubleValue: Double? {return NSNumberFormatter().numberFromString(self)?.doubleValue}
    
    func repeatTimes(times: Int) -> String{
        
        var strM = ""
        
        for _ in 0..<times {
            strM += self
        }
        
        return strM
    }
}