//
//  Reflect+Convert.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

/**  模型转字典  */
extension Reflect{
    
    
    func toDict() -> [String: Any]{
       
        var dict: [String: Any] = [:]
        
        self.properties { (name, type, value) -> Void in
            if type.isOptional{
                
                if type.realType == ReflectType.RealType.Class { //模型
                    
                    dict[name] = (value as? Reflect)?.toDict()
                
                    
                }else{ //基本属性
                    
                    dict[name] = "\(value)".replacingOccurrencesOfString("Optional(", withString: "").replacingOccurrencesOfString(")", withString: "").replacingOccurrencesOfString("\"", withString: "")
                }
            }else{
                
                if type.isReflect { //模型
                    
                    if type.isArray { //数组
                        
                        var dictM: [[String: Any]] = []
                    
                        let modelArr = value as! NSArray
                        
                        for item in  modelArr {
                            
                            let dict = (item as! Reflect).toDict()
                            
                            dictM.append(dict)
                        }
                        
                        dict[name] = dictM
                        
                    }else{
                       
                        dict[name] = (value as! Reflect).toDict()
                    }
                    
                    
                    
                    
                    
                }else{ //基本属性
                    
                    dict[name] = "\(value)".replacingOccurrencesOfString("Optional(", withString: "").replacingOccurrencesOfString(")", withString: "").replacingOccurrencesOfString("\"", withString: "")
                }
            }
            

            
            
            
        }
        
        return dict
    }
    
    
}

