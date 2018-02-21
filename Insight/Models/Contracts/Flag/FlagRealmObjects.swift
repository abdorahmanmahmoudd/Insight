//
//  FlagRealmObjects.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/21/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import RealmSwift

class FlaggedQuestion: Object {
    
    @objc dynamic var Id = ""
    @objc dynamic var flagValue = 0
    
    
    override static func primaryKey() -> String? {
        return "Id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["Id"]
    }
    
}
