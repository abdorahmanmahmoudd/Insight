//
//  SubscribtionRealmObjects.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/12/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import RealmSwift

class UserPackageItem: Object {
    
    @objc dynamic var id = Int()
    @objc dynamic var price = Int()
    @objc dynamic var expiryDate = Int()
    @objc dynamic var package : PackageDetail?
    @objc dynamic var package_duration : PackagesDurationRealm?
    @objc dynamic var promocode: PromocodeRealm?
    override static func primaryKey() -> String? {
        return "id"
    }
}

class PackageDetail: Object {
    @objc dynamic var id = Int()
    @objc dynamic var name = String()
    @objc dynamic var all : Bool = false
    let unlocked = List<PackageUnlockRealm>()
}

class PackageUnlockRealm: Object {
    @objc dynamic var all : Bool = false
    @objc dynamic var categoryId = Int()
    @objc dynamic var categoryName = String()
    let unlockedSubCategory = List<UnlockedSubCategoryRealm>()
}

class UnlockedSubCategoryRealm: Object{
    @objc dynamic var all : Bool = false
    @objc dynamic var subCategoryId = Int()
    @objc dynamic var subCategoryName = String()
    let unlockedSubSubCategory = List<UnlockedSubSubCategoryRealm>()
}

class UnlockedSubSubCategoryRealm: Object{
    
    @objc dynamic var subSubCategoryId = Int()
    @objc dynamic var subSubCategoryName = String()
}

class PackagesDurationRealm : Object{
    
    @objc dynamic var id = Int()
    @objc dynamic var duration = Int()
    @objc dynamic var discount = Int()
    @objc dynamic var price = Int()
}

class PromocodeRealm: Object {
    @objc dynamic var id = Int()
    @objc dynamic var code = String()
    @objc dynamic var discount = Int()
    @objc dynamic var message = String()
}


