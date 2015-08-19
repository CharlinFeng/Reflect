//
//  String.swift
//  Reflect
//
//  Created by 冯成林 on 15/8/19.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import Foundation


extension String{
    
    func contain(#subStr: String) -> Bool {return (self as NSString).rangeOfString(subStr).length > 0}
    
    func explode (separator: Character) -> [String] {
        return split(self, isSeparator: { (element: Character) -> Bool in
            return element == separator
        })
    }

}