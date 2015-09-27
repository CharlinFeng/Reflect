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
    
        //加载plist
        let path = NSBundle.mainBundle().pathForResource(name+".plist", ofType: nil)
        
        if path == nil {return nil}
        
        let dict = NSDictionary(contentsOfFile: path!)
        
        if dict == nil {return nil}
        
        return parse(dict: dict!)
    }
    
    class func parses(arr arr: NSArray) -> [Reflect]{
        
        var models: [Reflect] = []
        
        for (_ , dict) in arr.enumerate(){
            
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
                
                if !type.isArray { //不是数组
                    
                    if type.displayStyle != Mirror.DisplayStyle.Class { // 基本属性：String,Int,Float,Double,Bool
                        
                        model.setValue(dict[key], forKeyPath: name)
                        
                    }else{
                        
                        model.setValue((type.typeClass as! Reflect.Type).parse(dict: dict[key] as! NSDictionary), forKeyPath: name)
                        
                    }
                    
                }else{
                    
                    if let res = type.isAggregate(){
                        
                        var arrAggregate = []
                        
                        if res is Int.Type {arrAggregate = self.parseAggregateArray(dict[key] as! NSArray, temp: 0)}
                        
                        if res is Float.Type {arrAggregate = self.parseAggregateArray(dict[key] as! NSArray, temp: 0.0)}
                        
                        if res is Double.Type {arrAggregate = self.parseAggregateArray(dict[key] as! NSArray, temp: 0.0)}
                        
                        if res is String.Type {arrAggregate = self.parseAggregateArray(dict[key] as! NSArray, temp: "")}
                        
                        model.setValue(arrAggregate, forKeyPath: name)
                        
                    }else{
                        
                        let elementModelType =  ReflectType.makeClass(type) as! Reflect.Type
                        
                        //遍历
                        let dictKeyArr = dict[key] as! NSArray
                        
                        var arrM: [Reflect] = []
                        
                        for (_, value) in dictKeyArr.enumerate() {
                            
                            let elementModel = elementModelType.parse(dict: value as! NSDictionary)
                            
                            arrM.append(elementModel)
                        }
                        
                        model.setValue(arrM, forKeyPath: name)
                    }
                }

            }
        }
        
        return model
    }
    
    
    class func parseAggregateArray<T>(arrDict: NSArray,temp: T) -> [T]{
        
        var intArrM: [T] = []
        
        if arrDict.count == 0 {return intArrM}
        
        for (_, value) in arrDict.enumerate() {
            
            var element: T = temp
            
            if value is String {
            
                if temp is Int {element = Int((value as! String)) as! T}
                if temp is Float {element = (value as! String).floatValue as! T}
                if temp is Double {element = (value as! String).doubleValue as! T}
                element = value as! T
            }else{
                
                element = value as! T
            }
            
            intArrM.append(element)
        }
        
        return intArrM
    }
    
    
    /**  字段映射  */
    func mappingDict() -> [String: String]? {
        return nil
    }
    
    /**  字段忽略  */
    func ignorePropertiesForParse() -> [String]? {
        return nil
    }
    
}

