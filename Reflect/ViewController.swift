//
//  ViewController.swift
//  Reflect
//
//  Created by 冯成林 on 15/8/19.
//  Copyright (c) 2015年 冯成林. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let person = Person()

        person.properties { (name, type, value) -> Void in
            
            println("\(name): \(type.typeClass),\(type.dispositionDesc)")
        }
        
    }


}

