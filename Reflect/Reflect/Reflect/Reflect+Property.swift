//
//  Reflect+Property.swift
//  Reflect
//
//  Created by 冯成林 on 15/8/19.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

extension Reflect{
    
    var classNameString: String {return "\(self.dynamicType)"}
    
    func properties(property: (name: String, type: ReflectType, value: Any) -> Void){

        for p in mirror.children {
            
            let propertyNameString = p.label!
            
            let v = p.value
            
            let reflectType = ReflectType(propertyMirrorType: Mirror(reflecting: v), belongType: self.dynamicType)
                
            property(name: propertyNameString , type: reflectType, value: v)
        }
    }
    
    class func properties(property: (name: String, type: ReflectType, value: Any) -> Void){self.init().properties(property)}
}



