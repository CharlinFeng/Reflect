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
    
    
    public convenience required init?(coder aDecoder: NSCoder) {

        self.init()
        
        let ignorePropertiesForCoding = self.ignoreCodingPropertiesForCoding()
        
        self.properties { (name, type, value) -> Void in
            
            assert(type.check(), "[Charlin Feng]: Property '\(name)' type can not be a '\(type.realType.rawValue)' Type,Please use 'NSNumber' instead!")
            
            let hasValue = ignorePropertiesForCoding != nil

            
            if hasValue {
                
                let ignore = (ignorePropertiesForCoding!).contains(name)
                
                if !ignore {
                
                    self.setValue(aDecoder.decodeObject(forKey: name), forKeyPath: name)
                }
                
            }else{
                
                self.setValue(aDecoder.decodeObject(forKey: name), forKeyPath: name)
            }
        }
    }
    
    
    
    
    public func encode(with aCoder: NSCoder){
        
        let ignorePropertiesForCoding = self.ignoreCodingPropertiesForCoding()
        
        self.properties { (name, type, value) -> Void in
            
            let hasValue = ignorePropertiesForCoding != nil
            
            if hasValue {
                
                let ignore = (ignorePropertiesForCoding!).contains(name)
                
                if !ignore {
                    
                    aCoder.encode(value as? AnyObject, forKey: name)
                }
            }else{

                if type.isArray {
                    
                    if type.isReflect {
                        
                        aCoder.encode(value as? NSArray, forKey: name)
                        
                    }else {
                        aCoder.encode(value as? AnyObject, forKey: name)
                    }

                }else {
                    var v = "\(value)".replacingOccurrencesOfString(target: "Optional(", withString: "").replacingOccurrencesOfString(target: ")", withString: "")
                    v = v.replacingOccurrencesOfString(target: "\"", withString: "")
                    aCoder.encode(v, forKey: name)
                }
            }
        }
    }
    
    func parseOver(){}
}



