//
//  SubscribtionRealmObjects.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/12/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import RealmSwift

class UserPackageItem: Object {
    
    @objc dynamic var PackageId = Int()
    @objc dynamic var all : Bool = false
    @objc dynamic var expiryDate = Int()
    @objc dynamic var categoryId = Int()
    @objc dynamic var subCategoryId = Int()

}
