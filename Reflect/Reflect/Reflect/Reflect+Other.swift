//
//  Reflect+Common.swift
//  Reflect
//
//  Created by 冯成林 on 15/8/19.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation


/** 仿OC打印 */
extension Reflect: Printable{
    
    override var description: String {
    
        let pointAddr = NSString(format: "%p",unsafeBitCast(self, Int.self)) as String
        
        var printStr = self.classNameString + " <\(pointAddr)>: " + "\n{"
        
        self.properties { (name, type, value) -> Void in
            
            printStr += "\n\(name): \(value)"
        }
    
        printStr += "\n}"
        
        return printStr
    }
    
}