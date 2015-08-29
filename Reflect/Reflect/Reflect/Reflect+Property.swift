//
//  Reflect+Property.swift
//  Reflect
//
//  Created by 冯成林 on 15/8/19.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

extension Reflect{
    
    
    /** 获取类名 */
    var classNameString: String {return "\(self.dynamicType)"}
    
    /** 遍历成员属性：对象调用 */
    func properties(property: (name: String, type: ReflectType, value: Any) -> Void){

        for (var i=0; i<mirror.count; i++){
            
            if mirror[i].0 == "super" {continue}
            
            let propertyNameString = mirror[i].0
            
            let propertyValueInstaceMirrorType = mirror[i].1
            
            property(name:propertyNameString , type: ReflectType(propertyMirrorType: propertyValueInstaceMirrorType), value: propertyValueInstaceMirrorType.value)
        }
    }
    
    /**  静态方法调用  */
    class func properties(property: (name: String, type: ReflectType, value: Any) -> Void){self.init().properties(property)}
    
    
}



