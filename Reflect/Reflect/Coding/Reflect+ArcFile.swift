//
//  String+ArcFile.swift
//  Reflect
//
//  Created by 成林 on 15/8/23.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation


extension Reflect{
    
    static var DurationKey: String {return "Duration"}
    
    
    class func save(obj obj: AnyObject! , name: String, duration: NSTimeInterval) -> String{
        
        if duration > 0 {
            
            NSUserDefaults.standardUserDefaults().setDouble(NSDate().timeIntervalSince1970, forKey: name)
            NSUserDefaults.standardUserDefaults().setDouble(duration, forKey: name + DurationKey)
        }
        
        let path = pathWithName(name)
        
        if obj != nil {
            
            NSKeyedArchiver.archiveRootObject(obj, toFile: path)
            
        }else{
            
            let fm = NSFileManager.defaultManager()
            if fm.fileExistsAtPath(path) {
                
                if fm.isDeletableFileAtPath(path){
                    do {
                        try fm.removeItemAtPath(path)
                    }catch {
                        print("删除失败")
                    }
                }
            }
            
        }
        
        
        return path
    }
    
    class func read(name name: String) -> (Bool, AnyObject!){
        
        let time = NSUserDefaults.standardUserDefaults().doubleForKey(name)
        let duration = NSUserDefaults.standardUserDefaults().doubleForKey(name + DurationKey)
        let now = NSDate().timeIntervalSince1970
        let path = pathWithName(name)
        
        let obj = NSKeyedUnarchiver.unarchiveObjectWithFile(path)
    
        if time > 0 && duration > 0 && time + duration < now {return (false,obj)}
        if obj == nil {return (false,obj)}
        
        return (true,obj)
    }
    
    class func deleteReflectModel(name name: String){save(obj: nil, name: name, duration: 0)}
    
    static func pathWithName(name: String) -> String{
 
        let path = Reflect.cachesFolder! + "/" + name + ".arc"
        
        return path
    }

    static var cachesFolder: String? {
        
        let cacheRootPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.CachesDirectory, NSSearchPathDomainMask.UserDomainMask, true).last
    
        let cache_reflect_path = cacheRootPath! + "/" + "Reflect"
        
        let fm = NSFileManager.defaultManager()
        
        let existed = fm.fileExistsAtPath(cache_reflect_path)
        
        if !existed {
            
            do {
                try fm.createDirectoryAtPath(cache_reflect_path, withIntermediateDirectories: true, attributes: nil)
          
            }catch {}
            
        }else{
        
        }
        
        return cache_reflect_path
    }

    
    func ignoreCodingPropertiesForCoding() -> [String]? {return nil}
}