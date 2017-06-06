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
    
    var displayStyle: Mirror.DisplayStyle!
    
    var displayStyleDesc: String!
    
    var belongType: Any.Type!
    
    var isOptional: Bool = false
    
    var isArray: Bool = false
    
    var isReflect:Bool = false
    
    var realType: RealType = .None
    
    var propertyMirrorType: Mirror

    init(propertyMirrorType: Mirror, belongType: Any.Type){
        
        self.propertyMirrorType = propertyMirrorType
        
        self.belongType = belongType
        
        parseBegin()
    }
}


extension ReflectType{
    
    func parseBegin(){
        
        parseTypeName()
        
        parseTypeClass()
        
        parseTypedisplayStyle()
        
        parseTypedisplayStyleDesc()
    }
    
    func parseTypeName(){
        
        typeName = "\(propertyMirrorType.subjectType)".deleteSpecialStr()
    }
    
    func parseTypeClass(){
        
        typeClass = propertyMirrorType.subjectType
    }
    
    func parseTypedisplayStyle(){

        displayStyle = propertyMirrorType.displayStyle
        
        if displayStyle == nil && basicTypes.contains(typeName) {displayStyle = .struct}
        
        if extraTypes.contains(typeName) {displayStyle = .struct}
        
//        guard displayStyle != nil else {fatalError("[Charlin Feng]: DisplayStyle Must Have Value")}
    }
    
    func parseTypedisplayStyleDesc(){
        
        if displayStyle == nil {return}

        switch displayStyle! {
            
            case .struct: displayStyleDesc = "Struct"
            case .class: displayStyleDesc = "Class"
            case .optional: displayStyleDesc = "Optional"; isOptional = true;
            case .enum: displayStyleDesc = "Enum"
            case .tuple: displayStyleDesc = "Tuple"
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
    
    func fetchRealType(){
        
        if typeName.contain(subStr: "Array") {isArray = true}
        if typeName.contain(subStr: "Int") {realType = RealType.Int}
        else if typeName.contain(subStr: "Float") {realType = RealType.Float}
        else if typeName.contain(subStr: "Double") {realType = RealType.Double}
        else if typeName.contain(subStr: "String") {realType = RealType.String}
        else if typeName.contain(subStr: "Bool") {realType = RealType.Bool}
            else if typeName.contain(subStr: "NSNumber") {realType = RealType.Bool}
        else {realType = RealType.Class}
        
        if .Class == realType && !sdkTypes.contains(typeName) {
            
            isReflect = true
        }
    }
    
    class func makeClass(type: ReflectType) -> AnyClass {
        
        let arrayString = type.typeName
        
        var clsString = arrayString?.replacingOccurrencesOfString(target: "Array<", withString: "").replacingOccurrencesOfString(target: "Optional<", withString: "").replacingOccurrencesOfString(target: ">", withString: "") ?? ""
        
        clsString = arrayString?.replacingOccurrencesOfString(target: "Array<", withString: "") ?? ""

        clsString = clsString.replacingOccurrencesOfString(target: "Optional", withString: "")
        clsString = clsString.replacingOccurrencesOfString(target: "ImplicitlyUnwrapped", withString: "")
  
        
        var cls: AnyClass? = ClassFromString(str: clsString)
        
        if cls == nil && type.isReflect {
            
            var nameSpaceString = "\(type.belongType ?? Any.self).\(clsString)" ?? ""
            
            cls = ClassFromString(str: nameSpaceString)
            
        }
        
        return cls!
    }
    
    func isAggregate() -> Any!{
        
        var res: Any! = nil
        
        for (typeStr, type) in aggregateTypes {
        
            if typeName.contain(subStr: typeStr) {res = type}
        }
        
        return res
    }
    
    func check() -> Bool{
        
        if isArray {return true}
        
        return self.realType != RealType.Int && self.realType != RealType.Float && self.realType != RealType.Double
    }
}
