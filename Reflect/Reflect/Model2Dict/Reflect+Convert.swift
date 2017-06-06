//
//  Reflect+Convert.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation

extension Reflect{
    
    func toDict() -> [String: Any]{
       
        var dict: [String: Any] = [:]
        
        self.properties { (name, type, value) -> Void in
            if type.isOptional{
                
                if type.isReflect {
                    
                    dict[name] = (value as? Reflect)?.toDict()
                
                }else{
                    
                    dict[name] = "\(value)".replacingOccurrencesOfString(target: "Optional(", withString: "").replacingOccurrencesOfString(target: ")", withString: "").replacingOccurrencesOfString(target: "\"", withString: "")
                }
                
            }else{
                
                if type.isReflect {
                    
                    if type.isArray {
                        
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
                    
                }else{
                    
                    dict[name] = "\(value)".replacingOccurrencesOfString(target: "Optional(", withString: "").replacingOccurrencesOfString(target: ")", withString: "").replacingOccurrencesOfString(target: "\"", withString: "")
                }
            }
            
        }
        
        return dict
    }
}

