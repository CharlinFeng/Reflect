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
    var typeClass: Any.Type!
    var disposition: MirrorDisposition!
    var dispositionDesc: String!
    
    
    private var propertyMirrorType: MirrorType

    init(propertyMirrorType: MirrorType){
        
        self.propertyMirrorType = propertyMirrorType
        
        /** 开始解析 */
        parseBegin()
    }
}


extension ReflectType{
    

    /** 开始解析 */
    func parseBegin(){
        
        /** 解析类型名 */
        parseTypeName()
        
        /** 解析类型 */
        parseTypeClass()
        
        /** 类型性质 */
        parseTypeDisposition()
        
        /** 类型性质（字符串版本） */
        parseTypeDispositionDesc()
    }
    
    
    /** 解析类型名 */
    func parseTypeName(){
        
        typeName = "\(propertyMirrorType.valueType)"
    }
    
    /** 解析类型 */
    func parseTypeClass(){
        
        typeClass = propertyMirrorType.valueType
    }
    
    /** 类型性质 */
    func parseTypeDisposition(){
        
        disposition = propertyMirrorType.disposition
    }
    
    /** 类型性质（字符串版本） */
    func parseTypeDispositionDesc(){
        
        if disposition == nil {return}
        
        switch disposition! {
            
            case .Class: dispositionDesc = "Class"
            case .Struct: dispositionDesc = "Struct"
            case .Optional: dispositionDesc = "Optional"
            case .Enum: dispositionDesc = "Enum"
            case .Tuple: dispositionDesc = "Tuple"
            case .IndexContainer: dispositionDesc = "IndexContainer"
            case .KeyContainer: dispositionDesc = "KeyContainer"
            case .MembershipContainer: dispositionDesc = "MembershipContainer"
            case .Container: dispositionDesc = "Container"
            case .Aggregate: dispositionDesc = "Aggregate"
            case .ObjCObject: dispositionDesc = "ObjCObject"

        }
    }

    
}