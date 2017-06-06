//
//  Reflect+Property.swift
//  Reflect
//
//  Created by 冯成林 on 15/8/19.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

extension Reflect{
    
    var classNameString: String {return "\(type(of: self))"}
    
    func properties(property: (_ name: String, _ type: ReflectType, _ value: Any) -> Void){

        for p in mirror.children {
            
            let propertyNameString = p.label!
            
            let v = p.value
            
            let reflectType = ReflectType(propertyMirrorType: Mirror(reflecting: v), belongType: type(of: self))
            
            property(propertyNameString , reflectType, v)
        }
    }
    
    class func properties(property: (_ name: String, _ type: ReflectType, _ value: Any) -> Void){self.init().properties(property: property)}
}



