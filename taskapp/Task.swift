//
//  Task.swift
//  taskapp
//
//  Created by 齋藤友祐 on 2020/11/23.
//  Copyright © 2020 yusuke.saito. All rights reserved.
//

import RealmSwift

class Task: Object {
    
    @objc dynamic var id = 0
    
    @objc dynamic var title = ""
    
    @objc dynamic var contents = ""
    
    @objc dynamic var date = Date()
    
    override static func  primaryKey() -> String? {
        return "id"
    }
    
}
