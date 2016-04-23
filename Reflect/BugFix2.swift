//
//  BugFix2.swift
//  Reflect
//
//  Created by 冯成林 on 16/4/23.
//  Copyright © 2016年 冯成林. All rights reserved.
//

import Foundation

let appUserDict: NSDictionary = [
    "address" : "address",
    "car_type" :     [
        "id" : "1",
        "type" : "C1",
    ],
    "class_info" :     [
        "id" : "1",
        "name" : "class_info",
    ],
    "class_type" :     [
        "1_1_money" : "100",
        "4_1_money" : "50",
        "bespoke_cycle" : "1",
        "can_money" : "1",
        "driver_school" : "1",
        "id" : "1",
        "name" : "class_type",
        "subject" : "0",
    ],
    "driver_school" :     [
        "city" : "1",
        "id" : "1",
        "is_del" : "1",
        "name" : "driver_school",
    ],
    "id" : "10",
    "id_card" : "511632349835898588",
    "last_login_time" : "1461379075",
    "name" : "冯成林",
    "header_img": [
        ["id":"18","url":"/Public/yyxc/student/2016/04/5719f90878a11.png","thumb":"/Public/yyxc/student/2016/04/thumb_300X300_5719f90878a11.png"]
    ],
    "now_stage" :     [
        "id" : "2",
        "name" : "now_stage",
        "subject" : "2",
    ],
    "now_subject" :     [
        "id" : "2",
        "name" : "now_subject",
    ],
    "phone" : "13000000000",
    "pwd" : "670B14728AD9902AECBA32E22FA4F6BD",
    "register_time" : "1461322595",
    "school_info" : "http:www.baidu.com",
    "shuttle_bus_info" : "http:www.baidu.com",
    "subject_1" :     [
        "percentage" : "100",
        "subject_id" : "1",
    ],
    "subject_2" :     [
        "percentage" : "30",
        "subject_id" : "2",
    ],
    "subject_3" :     [
        "percentage" : "0",
        "subject_id" : "3",
    ],
    "subject_4" :     [
        "percentage" : "0",
        "subject_id" : "4",
    ],
    "token" : "ea204361fe7f024b130143eb3e189a18",
]




/** 用户模型 */
class AppUserModel: Reflect {
    
    var token,name,phone,address,id_card,pwd,register_time,last_login_time,shuttle_bus_info,school_info: String?
    var car_type: CarType?
    var driver_school: DriverSchool?
    var class_type: ClassType?
    var now_stage: NowStage?
    var now_subject: NowSubject?
    var header_img: [HeaderImg]?
    var class_info: ClassInfo?
    var subject_1: Subject_1?
    var subject_2: Subject_2?
    var subject_3: Subject_3?
    var subject_4: Subject_4?
    
    class func parse(){
    
        let au = AppUserModel.parse(dict: appUserDict)
        AppUserModel.save(obj: au, name: "AppUserModel", duration: 1000)
        let res = AppUserModel.read(name: "AppUserModel")
        let u = res.1 as? AppUserModel
        
        print("au_arc:\(res.1)")
    }
}




class CarType: Reflect {
    
    var id,type: String?
}

class DriverSchool: Reflect {
    var id,name,city :String?
    var is_del: Bool = false
}

class ClassType: Reflect {
    var id,name,bespoke_cycle,driver_school,subject,can_money,money_1_1,money_4_1: String?
}

class NowStage: Reflect {
    var id,name,subject: String?
}

class NowSubject: Reflect {
    
    var id,name: String?
}

class HeaderImg: Reflect {
    var id,url,thumb: String?
}

class ClassInfo: Reflect {
    var id,name: String?
}

class Subject_1: Reflect {
    var subject_id,percentage: String?
}

class Subject_2: Reflect {
    var subject_id,percentage: String?
}

class Subject_3: Reflect {
    var subject_id,percentage: String?
}

class Subject_4: Reflect {
    var subject_id,percentage: String?
}



