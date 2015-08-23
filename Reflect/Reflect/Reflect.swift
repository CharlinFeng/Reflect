//
//  Reflect.swift
//  Reflect
//
//  Created by 冯成林 on 15/8/19.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

class Reflect: NSObject, NSCoding{
    
    lazy var mirror: MirrorType = {reflect(self)}()

    required override init(){}
    
    required convenience init(coder aDecoder: NSCoder) {
        
        self.init()
        
        self.properties { (name, type, value) -> Void in
             assert(type.check(), "[Charlin Feng]: Property '\(name)' type can not be a '\(type.realType.rawValue)' Type,Please use 'NSNumber' instead!")
            self.setValue(aDecoder.decodeObjectForKey(name), forKeyPath: name)
        }
        
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        self.properties { (name, type, value) -> Void in
            
            aCoder.encodeObject(value as? AnyObject, forKey: name)
        }
        
    }
    
    
}


















extension Reflect{
    
    /**  字段映射  */
    func mappingDict() -> [String: String]? {
        return nil
    }
    
    /**  字段忽略  */
    func ignoreProperties() -> [String]? {
        return nil
    }

}


