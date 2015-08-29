//
//  Reflect+Common.swift
//  Reflect
//
//  Created by 冯成林 on 15/8/19.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation


/** 仿OC打印 */
extension Reflect {
    
    override var description: String {
    
        let pointAddr = NSString(format: "%p",unsafeBitCast(self, Int.self)) as String
        
        var printStr = self.classNameString + " <\(pointAddr)>: " + "\n{"
        
        self.properties { (name, type, value) -> Void in
            
            if type.isArray {
                
                printStr += "\n\n['\(name)']: \(value)"
                
            }else{
                
                printStr += "\n\(name): \(value)"
            }
        }
    
        printStr += "\n}"
        
        return printStr
    }
    
}



extension String{
    
    func contain(subStr: String) -> Bool {return (self as NSString).rangeOfString(subStr).length > 0}
    
    func explode (separator: String) -> [String] {
        return self.componentsSeparatedByString(separator)
    }
    
    func replacingOccurrencesOfString(target: String, withString: String) -> String{
        return (self as NSString).stringByReplacingOccurrencesOfString(target, withString: withString)
    }
    
    var floatValue: Float? {return NSNumberFormatter().numberFromString(self)?.floatValue}
    var doubleValue: Double? {return NSNumberFormatter().numberFromString(self)?.doubleValue}
}