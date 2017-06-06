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
    
    
    class func save(obj: AnyObject! , name: String, duration: TimeInterval) -> String{
        
        if duration > 0 {
            
            UserDefaults.standard.set(NSDate().timeIntervalSince1970, forKey: name)
            UserDefaults.standard.set(duration, forKey: name + DurationKey)
        }
        
        let path = pathWithName(name: name)
        
        if obj != nil {
            
            NSKeyedArchiver.archiveRootObject(obj, toFile: path)
            
        }else{
            
            let fm = FileManager.default
            if fm.fileExists(atPath: path) {
                
                if fm.isDeletableFile(atPath: path){
                    do {
                        try fm.removeItem(atPath: path)
                    }catch {
                        
                    }
                }
            }
            
        }
        
        
        return path
    }
    
    class func read(name: String) -> (Bool, AnyObject?){
        
        let time = UserDefaults.standard.double(forKey: name)
        let duration = UserDefaults.standard.double(forKey: name + DurationKey)
        let now = NSDate().timeIntervalSince1970
        let path = pathWithName(name: name)
        
        let obj = NSKeyedUnarchiver.unarchiveObject(withFile: path)
    
        if time > 0 && duration > 0 && time + duration < now {return (false,obj as AnyObject?)}
        if obj == nil {return (false,obj as AnyObject?)}
        
        return (true,obj as AnyObject?)
    }
    
    class func deleteReflectModel(name: String){save(obj: nil, name: name, duration: 0)}
    
    static func pathWithName(name: String) -> String{
 
        let path = Reflect.cachesFolder! + "/" + name + ".arc"
        
        return path
    }

    static var cachesFolder: String? {
        
        let cacheRootPath = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.cachesDirectory, FileManager.SearchPathDomainMask.userDomainMask, true).last
    
        let cache_reflect_path = cacheRootPath! + "/" + "Reflect"
        
        let fm = FileManager.default
        
        let existed = fm.fileExists(atPath: cache_reflect_path)
        
        if !existed {
            
            do {
                try fm.createDirectory(atPath: cache_reflect_path, withIntermediateDirectories: true, attributes: nil)
          
            }catch {}
            
        }else{
        
        }
        
        return cache_reflect_path
    }

    
    func ignoreCodingPropertiesForCoding() -> [String]? {return nil}
}
