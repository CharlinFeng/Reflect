//
//  String+ArcFile.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation


extension Reflect{
    
    class func save(obj obj: AnyObject! , name: String!, duration: NSTimeInterval) -> String{
        
        if duration > 0 {
            NSUserDefaults.standardUserDefaults().setDouble(NSDate().timeIntervalSince1970, forKey: name)
            NSUserDefaults.standardUserDefaults().setDouble(duration, forKey: name+"duration")
        }
        
        if obj is [AnyObject]{assert(name != nil, "[Charlin Feng]: Name can't be empty when you Archive an array!")}
        
        let data = obj ?? self.init()
        
        let path = pathWithName(obj: data, name: name)
        
        if obj != nil {
            NSKeyedArchiver.archiveRootObject(data, toFile: path)
        }else{
            
            let fm = NSFileManager.defaultManager()
            if fm.isDeletableFileAtPath(path){
                do {
                    try fm.removeItemAtPath(path)
                }catch {
                    print("删除失败")
                }
                
            }
        }
        
        
        return path
    }
    
    class func read(name name: String!) -> (Bool, AnyObject!){
        
        let time = NSUserDefaults.standardUserDefaults().doubleForKey(name)
        let duration = NSUserDefaults.standardUserDefaults().doubleForKey(name+"duration")
        let now = NSDate().timeIntervalSince1970
        let path = pathWithName(obj: self.init(), name: name)
        
        let obj = NSKeyedUnarchiver.unarchiveObjectWithFile(path)
    
        if time > 0 && duration > 0 && time + duration < now {return (false,obj)}
        if obj == nil {return (false,obj)}
        
        return (true,obj)
    }
    
    class func delete(name name: String!){save(obj: nil, name: name, duration: 0)}
    
    
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