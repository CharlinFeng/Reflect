//
//  Reflect+Parse.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation


extension Reflect{
    
    class func parsePlist(name: String) -> Self?{
    
        let path = Bundle.main.path(forResource: name+".plist", ofType: nil)
        
        if path == nil {return nil}
        
        let dict = NSDictionary(contentsOfFile: path!)
        
        if dict == nil {return nil}
        
        return parse(dict: dict!)
    }
    
    class func parses(arr arr: NSArray) -> [Reflect]{
        
        var models: [Reflect] = []
        
        for (_ , dict) in arr.enumerated(){
            
            let model = self.parse(dict: dict as! NSDictionary)
            
            models.append(model)
        }
        
        return models
    }
    
    
    class func parse(dict dict: NSDictionary) -> Self{
        
        let model = self.init()
        
        let mappingDict = model.mappingDict()
        
        let ignoreProperties = model.ignorePropertiesForParse()

        model.properties { (name, type, value) -> Void in
            
            let dataDictHasKey = dict[name] != nil
            let mappdictDictHasKey = mappingDict?[name] != nil
            let needIgnore = ignoreProperties == nil ? false : (ignoreProperties!).contains(name)
            
            if (dataDictHasKey || mappdictDictHasKey) && !needIgnore {

                let key = mappdictDictHasKey ? mappingDict![name]! : name
                
                if !type.isArray {
                    
                    
                    
                    if !type.isReflect {
                      
                        if type.typeClass == Bool.self { //bool
                            
                            model.setValue((dict[key] as AnyObject).boolValue, forKeyPath: name)
                            
                        }else if type.isOptional && type.realType == ReflectType.RealType.String{
                            
                            let v = dict[key]
                            
                            if v != nil {
                            
                                let str_temp = "\(v!)"
                                model.setValue(str_temp, forKeyPath: name)
                            }
                            
                        }else{
                            model.setValue(dict[key], forKeyPath: name)
                        }
                        
                        
                        
                    }else{
                        
                        //这里是模型
                        //首选判断字典中是否有值
                        let dictValue = dict[key]
                        
                        if dictValue != nil { //字典中有模型
                            
                            let modelValue = model.value(forKeyPath: key)
                            
                            if modelValue != nil { //子模型已经初始化
                                
                                model.setValue((type.typeClass as! Reflect.Type).parse(dict: dict[key] as! NSDictionary), forKeyPath: name)
                                
                            }else{ //子模型没有初始化
                                
                                //先主动初始化
                                var tn = type.typeName ?? ""
                                var cls = ClassFromString(str: tn)
                                model.setValue((cls as! Reflect.Type).parse(dict: dict[key] as! NSDictionary), forKeyPath: name)
                            }
                        }
                        
                    }
                    
                }else{
                    
                    if let res = type.isAggregate(){
                        
        
                        if res is Int.Type {
                            
                            var arrAggregate: [Int] = []
                            arrAggregate = parseAggregateArray(arrDict: dict[key] as! NSArray, basicType: ReflectType.BasicType.Int, ins: 0)
                            model.setValue(arrAggregate, forKeyPath: name)
                            
                        }else if res is Float.Type {
                            
                            var arrAggregate: [Float] = []
                            arrAggregate = parseAggregateArray(arrDict: dict[key] as! NSArray, basicType: ReflectType.BasicType.Float, ins: 0.0)
                            model.setValue(arrAggregate, forKeyPath: name)
                            
                        }else if res is Double.Type {
                            
                            var arrAggregate: [Double] = []
                            arrAggregate = parseAggregateArray(arrDict: dict[key] as! NSArray, basicType: ReflectType.BasicType.Double, ins: 0.0)
                            model.setValue(arrAggregate, forKeyPath: name)
                            
                        }else if res is String.Type {
                            
                            var arrAggregate: [String] = []
                            arrAggregate = parseAggregateArray(arrDict: dict[key] as! NSArray, basicType: ReflectType.BasicType.String, ins: "")
                            model.setValue(arrAggregate, forKeyPath: name)
                            
                        }else if res is NSNumber.Type {
                            
                            var arrAggregate: [NSNumber] = []
                            arrAggregate = parseAggregateArray(arrDict: dict[key] as! NSArray, basicType: ReflectType.BasicType.NSNumber, ins: NSNumber())
                            model.setValue(arrAggregate, forKeyPath: name)
                            
                        }else{
                            
                            var arrAggregate: [AnyObject] = []
                            arrAggregate = dict[key] as! [AnyObject]
                            model.setValue(arrAggregate, forKeyPath: name)
                            
                        }
                        
                        
                        
                    }else{
                        
                        let elementModelType =  ReflectType.makeClass(type: type) as! Reflect.Type
                        
                        let dictKeyArr = dict[key] as! NSArray
                        
                        var arrM: [Reflect] = []
                        
                        for (_, value) in dictKeyArr.enumerated() {
                            
                            let elementModel = elementModelType.parse(dict: value as! NSDictionary)
                            
                            arrM.append(elementModel)
                        }
                        
                        model.setValue(arrM, forKeyPath: name)
                    }
                }

            }
        }
        
        model.parseOver()
        
        return model
    }
    
    
    class func parseAggregateArray<T>(arrDict: NSArray,basicType: ReflectType.BasicType, ins: T) -> [T]{
        
        var intArrM: [T] = []
        
        if arrDict.count == 0 {return intArrM}
        
        for (_, value) in arrDict.enumerated() {
            
            var element: T = ins
            
            let v = "\(value)"
            
            
            
            
            if T.self is Int.Type {
                element = Int(Float(v)!) as! T
            }
            else if T.self is Float {element = v.floatValue as! T}
            else if T.self is Double.Type {element = v.doubleValue as! T}
            else if T.self is NSNumber.Type {element = NSNumber(value: v.doubleValue!) as! T}
            else if T.self is String.Type {element = v as! T}
            else{element = value as! T}
            
            intArrM.append(element)
        }
        
        return intArrM
    }
    
    
    func mappingDict() -> [String: String]? {return nil}
    
    func ignorePropertiesForParse() -> [String]? {return nil}
}

