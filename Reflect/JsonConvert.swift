//
//  JsonConvert.swift
//  Reflect
//
//  Created by Charlin on 16/6/6.
//  Copyright © 2016年 冯成林. All rights reserved.
//

import Foundation

let jsonStr = "{\"name\":null,\"age\":32}"


class CoachModel: Reflect {
    
    var name: String?
    var age: NSNumber?

    static func parse(){
    
        let d = jsonStr.dataUsingEncoding(NSUTF8StringEncoding)
        
        do{
//            id obj=[NSJSONSerialization JSONObjectWithData:correctStringData options:NSJSONReadingAllowFragments error:&error];
            let dict = try? NSJSONSerialization.JSONObjectWithData(d!, options: NSJSONReadingOptions.AllowFragments)
            let m = CoachModel.parse(dict: dict as! NSDictionary)
            
            print(m)
            
        } catch {
            
            print("")
            
        }
        
        
        
    }
}