//
//	PackageUnlocked.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class PackageUnlocked : NSObject, NSCoding{

	var all : Bool!
	var categoryId : Int!
	var categoryName : String!
	var unlockedSubCategory : [UnlockedSubCategory]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		all = dictionary["all"] as? Bool
		categoryId = dictionary["category_id"] as? Int
		categoryName = dictionary["category_name"] as? String
        unlockedSubCategory = [UnlockedSubCategory]()
        if let unlockedSubCategoryArray = dictionary["unlocked_sub_category"] as? [[String:Any]]{
            for dic in unlockedSubCategoryArray{
                let value = UnlockedSubCategory(fromDictionary: dic)
                unlockedSubCategory.append(value)
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
		if categoryId != nil{
			dictionary["category_id"] = categoryId
		}
		if categoryName != nil{
			dictionary["category_name"] = categoryName
		}
        if unlockedSubCategory != nil{
            var dictionaryElements = [[String:Any]]()
            for unlockedSubCategoryElement in unlockedSubCategory {
                dictionaryElements.append(unlockedSubCategoryElement.toDictionary())
            }
            dictionary["unlocked_sub_category"] = dictionaryElements
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
         categoryId = aDecoder.decodeObject(forKey: "category_id") as? Int
         categoryName = aDecoder.decodeObject(forKey: "category_name") as? String
         unlockedSubCategory = aDecoder.decodeObject(forKey :"unlocked_sub_category") as? [UnlockedSubCategory]

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
		if categoryId != nil{
			aCoder.encode(categoryId, forKey: "category_id")
		}
		if categoryName != nil{
			aCoder.encode(categoryName, forKey: "category_name")
		}
        if unlockedSubCategory != nil{
            aCoder.encode(unlockedSubCategory, forKey: "unlocked_sub_category")
        }

	}

}
