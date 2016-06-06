//
//  JsonConvert.swift
//  Reflect
//
//  Created by Charlin on 16/6/6.
//  Copyright © 2016年 冯成林. All rights reserved.
//

import Foundation

let jsonStr = "{'name':'张三','age':32}"

class CoachModel: Reflect {
    
    var name: String?
    var age: NSNumber?

    static func parse(json: String?){
    
        let d = json?.dataUsingEncoding(NSUTF8StringEncoding)
        
        do{
            try?{
                let dict = NSJSONSerialization.JSONObjectWithData(d!, options: NSJSONReadingOptions.AllowFragments)
            }
        } catch {
        
        }
        
        
        
    }
}