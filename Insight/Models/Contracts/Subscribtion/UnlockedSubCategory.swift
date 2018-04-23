//
//	UnlockedSubCategory.swift
//
//	Create by abdelrahman.youssef on 23/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class UnlockedSubCategory : NSObject, NSCoding{

	var all : Bool!
	var subCategoryId : Int!
	var subCategoryName : String!
	var unlockedSubSubCategory : [UnlockedSubSubCategory]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		all = dictionary["all"] as? Bool
		subCategoryId = dictionary["sub_category_id"] as? Int
		subCategoryName = dictionary["sub_category_name"] as? String
		unlockedSubSubCategory = [UnlockedSubSubCategory]()
		if let unlockedSubSubCategoryArray = dictionary["unlocked_sub_sub_category"] as? [[String:Any]]{
			for dic in unlockedSubSubCategoryArray{
				let value = UnlockedSubSubCategory(fromDictionary: dic)
				unlockedSubSubCategory.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if all != nil{
			dictionary["all"] = all
		}
		if subCategoryId != nil{
			dictionary["sub_category_id"] = subCategoryId
		}
		if subCategoryName != nil{
			dictionary["sub_category_name"] = subCategoryName
		}
		if unlockedSubSubCategory != nil{
			var dictionaryElements = [[String:Any]]()
			for unlockedSubSubCategoryElement in unlockedSubSubCategory {
				dictionaryElements.append(unlockedSubSubCategoryElement.toDictionary())
			}
			dictionary["unlocked_sub_sub_category"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         all = aDecoder.decodeObject(forKey: "all") as? Bool
         subCategoryId = aDecoder.decodeObject(forKey: "sub_category_id") as? Int
         subCategoryName = aDecoder.decodeObject(forKey: "sub_category_name") as? String
         unlockedSubSubCategory = aDecoder.decodeObject(forKey :"unlocked_sub_sub_category") as? [UnlockedSubSubCategory]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if all != nil{
			aCoder.encode(all, forKey: "all")
		}
		if subCategoryId != nil{
			aCoder.encode(subCategoryId, forKey: "sub_category_id")
		}
		if subCategoryName != nil{
			aCoder.encode(subCategoryName, forKey: "sub_category_name")
		}
		if unlockedSubSubCategory != nil{
			aCoder.encode(unlockedSubSubCategory, forKey: "unlocked_sub_sub_category")
		}

	}

}