//
//  Reflect+Type.swift
//  Reflect
//
//  Created by 冯成林 on 15/8/19.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

class ReflectType {
    
    var typeName: String!
    
    
    
    
    private var typeValue: Any

    init(typeValue: Any){
        
        self.typeValue = typeValue
        
        /** 开始解析 */
        parseBegin()
    }
}


extension ReflectType{
    

    /** 开始解析 */
    func parseBegin(){
        
        /** 解析类型名 */
        parseTypeName()
        
    }
    
    
    /** 解析类型名 */
    func parseTypeName(){
        
        self.typeName = "\(typeValue.dynamicType)"
    }
    
}