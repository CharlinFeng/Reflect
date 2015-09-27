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
    
    var displayStyle: Mirror.DisplayStyle!
    
    var displayStyleDesc: String!
    
    var belongType: Any.Type!
    
    /**  是否是可选类型  */
    var isOptional: Bool = false
    
    /**  是否是数组  */
    var isArray: Bool = false
    
    /**  是否为自定义对象：此对象一定是Reflect的子类  */
    var isReflect:Bool = false
    
    /**  真实类型: 可选 + 数组  */
    var realType: RealType = .None
    
    private var propertyMirrorType: Mirror

    init(propertyMirrorType: Mirror, belongType: Any.Type){
        
        self.propertyMirrorType = propertyMirrorType
        self.belongType = belongType
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
        parseTypedisplayStyle()
        
        /** 类型性质（字符串版本） */
        parseTypedisplayStyleDesc()
    }
    
    
    /** 解析类型名 */
    func parseTypeName(){
        
        typeName = "\(propertyMirrorType.subjectType)".deleteSpecialStr()
    }
    
    /** 解析类型 */
    func parseTypeClass(){
        
        typeClass = propertyMirrorType.subjectType
    }
    
    /** 类型性质 */
    func parseTypedisplayStyle(){

        displayStyle = propertyMirrorType.displayStyle
        
        if displayStyle == nil && basicTypes.contains(typeName) {displayStyle = .Struct}
        
        if extraTypes.contains(typeName) {displayStyle = .Struct}
        
        guard displayStyle != nil else {fatalError("[Charlin Feng]: DisplayStyle Must Have Value")}
    }
    
    /** 类型性质（字符串版本） */
    func parseTypedisplayStyleDesc(){
        
        if displayStyle == nil {return}

        switch displayStyle! {
            
            case .Struct: displayStyleDesc = "Struct"
            case .Class: displayStyleDesc = "Class"
            case .Optional: displayStyleDesc = "Optional"; isOptional = true;
            case .Enum: displayStyleDesc = "Enum"
            case .Tuple: displayStyleDesc = "Tuple"
            default: displayStyleDesc = "Other: Collection/Dictionary/Set"

        }
        fetchRealType()
    }
}



extension ReflectType{
    
    enum BasicType: String{
        
        case String
        case Int
        case Float
        case Double
        case Bool
        case NSNumber
    }


    enum RealType: String{
        
        case None = "None"
        case Int = "Int"
        case Float = "Float"
        case Double = "Double"
        case String = "String"
        case Bool = "Bool"
        case Class = "Class"
    }
}




extension ReflectType{
    
    var basicTypes: [String] {return ["String", "Int", "Float", "Double", "Bool"]}
    var extraTypes: [String] {return ["__NSCFNumber", "_NSContiguousString", "NSTaggedPointerString"]}
    var sdkTypes: [String] {return ["__NSCFNumber", "NSNumber", "_NSContiguousString", "UIImage", "_NSZeroData"]}
    
    var aggregateTypes: [String: Any.Type] {return ["String": String.self, "Int": Int.self, "Float": Float.self, "Double": Double.self, "Bool": Bool.self, "NSNumber": NSNumber.self]}
    
    /**  获取真实类型  */
    func fetchRealType(){
        
        if typeName.contain(subStr: "Array") {isArray = true}
        if typeName.contain(subStr: "Int") {realType = RealType.Int}
        else if typeName.contain(subStr: "Float") {realType = RealType.Float}
        else if typeName.contain(subStr: "Double") {realType = RealType.Double}
        else if typeName.contain(subStr: "String") {realType = RealType.String}
        else if typeName.contain(subStr: "Bool") {realType = RealType.Bool}
        else {realType = RealType.Class}
        
        if .Class == realType && !sdkTypes.contains(typeName) {
            
            isReflect = true
        }
    }
    
    /**  数组Element类型截取：截取字符串并返回一个类型  */
    class func makeClass(type: ReflectType) -> AnyClass {
        
        let arrayString = type.typeName
        
        let clsString = arrayString.replacingOccurrencesOfString("Array<", withString: "").replacingOccurrencesOfString("Optional<", withString: "").replacingOccurrencesOfString(">", withString: "")
        
        var cls: AnyClass? = ClassFromString(clsString)
        
        if cls == nil && type.isReflect {
            
            let nameSpaceString = "\(type.belongType).\(clsString)"
            
            cls = ClassFromString(nameSpaceString)
        }
        
        return cls!
    }
    
    
    /**  是否为基础数组类型  */
    func isAggregate() -> Any!{
        
        var res: Any! = nil
        
        for (typeStr, type) in aggregateTypes {
        
            if typeName.contain(subStr: typeStr) {res = type}
        }
        
        return res
    }
    
    /**  check  */
    func check() -> Bool{
        
        if isArray {return true}
        
        return self.realType != RealType.Int && self.realType != RealType.Float && self.realType != RealType.Double
    }
}