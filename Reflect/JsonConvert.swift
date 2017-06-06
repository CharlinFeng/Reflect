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
    
        let d = jsonStr.data(using: String.Encoding.utf8)
        
        do{
//            id obj=[NSJSONSerialization JSONObjectWithData:correctStringData options:NSJSONReadingAllowFragments error:&error];
            let dict = try? JSONSerialization.jsonObject(with: d!, options: JSONSerialization.ReadingOptions.allowFragments)
            let m = CoachModel.parse(dict: dict as! NSDictionary)
            
            print(m)
            
        } catch {
            
            print("")
            
        }
        
        
        
    }
}
