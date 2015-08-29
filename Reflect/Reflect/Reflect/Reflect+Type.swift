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
    
    /**  系统解析出的Type  */
    var typeClass: Any.Type!
    
    var disposition: _MirrorDisposition!
    
    var dispositionDesc: String!
    
    /**  是否是可选类型  */
    var isOptional: Bool = false
    
    /**  是否是数组  */
    var isArray: Bool = false
    
    /**  真实类型: 可选 + 数组  */
    var realType: RealType = .None
    
    
    private var propertyMirrorType: _MirrorType

    init(propertyMirrorType: _MirrorType){
        
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
            case .Optional: dispositionDesc = "Optional"; isOptional = true;
            case .Enum: dispositionDesc = "Enum"
            case .Tuple: dispositionDesc = "Tuple"
            case .IndexContainer: dispositionDesc = "IndexContainer"; isArray = true;
            case .KeyContainer: dispositionDesc = "KeyContainer"
            case .MembershipContainer: dispositionDesc = "MembershipContainer"
            case .Container: dispositionDesc = "Container"
            case .Aggregate: dispositionDesc = "Aggregate"
            case .ObjCObject: dispositionDesc = "ObjCObject"

        }
        fetchRealType()
    }
}



extension ReflectType{
    
    enum RealType: String{
        
        case None = "None"
        case Int = "Int"
        case Float = "Float"
        case Double = "Double"
        case String = "String"
        case Bool = "Bool"
        case ObjCObject = "ObjCObject"
        case Class = "Class"
    }
}




extension ReflectType{
    
    var aggregateTypes: [String: Any.Type] {return ["String": String.self, "Int": Int.self, "Float": Float.self, "Double": Double.self, "Bool": Bool.self]}
    
    /**  获取真实类型  */
    func fetchRealType(){
        
        if typeName.contain("Array") {isArray = true}

        if typeName.contain("Int") {realType = RealType.Int}
        else if typeName.contain("Float") {realType = RealType.Float}
        else if typeName.contain("Double") {realType = RealType.Double}
        else if typeName.contain("String") {realType = RealType.String}
        else if typeName.contain("Bool") {realType = RealType.Bool}
        else if disposition == _MirrorDisposition.ObjCObject {realType = RealType.ObjCObject}
        else {realType = RealType.Class}
        
        
    }
    
    /**  数组Element类型截取：截取字符串并返回一个类型  */
    class func makeClass(arrayString: String) -> Any {
        
        var clsString = arrayString.replacingOccurrencesOfString("Swift.Array<", withString: "").replacingOccurrencesOfString("Swift.Optional<", withString: "").replacingOccurrencesOfString(">", withString: "")
        
        return ClassFromString(clsString)
    }
    
    
    /**  是否为基础数组类型  */
    
    func isAggregate() -> Any!{
        
        var res: Any! = nil
        
        for (typeStr, type) in aggregateTypes {
        
            if typeName.contain(typeStr) {res = type}
        }
        
        return res
    }
    
    /**  check  */
    func check() -> Bool{
        
        return self.realType != RealType.Int && self.realType != RealType.Float && self.realType != RealType.Double
    }
}