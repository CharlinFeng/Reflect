//
//  String+ArcFile.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation


extension Reflect{
    

    class func save(obj obj: AnyObject! , name: String!) -> String{
        
        if obj is [AnyObject]{assert(name != nil, "[Charlin Feng]: Name can't be empty when you Archive an array!")}
        
        let data = obj ?? self.init()
        
        let path = pathWithName(obj: data, name: name)

        NSKeyedArchiver.archiveRootObject(data, toFile: path)
       
        return path
    }
    
    class func read(name name: String!) -> AnyObject?{
        
        let path = pathWithName(obj: self.init(), name: name)
        
        return NSKeyedUnarchiver.unarchiveObjectWithFile(path)
    }
    
    class func delete(name name: String!){save(obj: nil, name: name)}
    
    
    static func pathWithName(obj obj: AnyObject, name: String!) -> String{
        
        let fileName = name ?? Mirror(reflecting: obj).description
        
        let path = ArcFile.cachesFolder! + "/" + fileName + ".arc"
        
        return path
    }
    

    class ArcFile {

        static var cachesFolder: String? {return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last}
    }
    
    func ignoreCodingPropertiesForCoding() -> [String]? {return nil}
}