//
//  Reflect.swift
//  Reflect
//
//  Created by 冯成林 on 15/8/19.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

class Reflect: NSObject, NSCoding{
    
    lazy var mirror: Mirror = {Mirror(reflecting: self)}()

    required override init(){}
    
    required convenience init?(coder aDecoder: NSCoder) {
        
        self.init()
        
        let ignorePropertiesForCoding = self.ignoreCodingPropertiesForCoding()
        
        self.properties { (name, type, value) -> Void in
             assert(type.check(), "[Charlin Feng]: Property '\(name)' type can not be a '\(type.realType.rawValue)' Type,Please use 'NSNumber' instead!")
            
            let hasValue = ignorePropertiesForCoding != nil

            if hasValue {
                
                let ignore = (ignorePropertiesForCoding!).contains(name)
                
                if !ignore {
                
                    self.setValue(aDecoder.decodeObjectForKey(name), forKeyPath: name)
                }
            }else{
                self.setValue(aDecoder.decodeObjectForKey(name), forKeyPath: name)
            }
        }
    }
    
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        let ignorePropertiesForCoding = self.ignoreCodingPropertiesForCoding()
        
        self.properties { (name, type, value) -> Void in
            
            let hasValue = ignorePropertiesForCoding != nil
            
            if hasValue {
                
                let ignore = (ignorePropertiesForCoding!).contains(name)
                
                if !ignore {
                    
                    aCoder.encodeObject(value as? AnyObject, forKey: name)
                }
            }else{
                aCoder.encodeObject(value as? AnyObject, forKey: name)
            }
            
        }
        
    }
}



