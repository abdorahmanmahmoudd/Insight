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
    @objc dynamic var photoPath : String? = nil
    @objc dynamic var note : String? = nil
    @objc dynamic var voiceNotePath : String? = nil
    
    
    override static func primaryKey() -> String? {
        return "Id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["Id"]
    }
    
}
