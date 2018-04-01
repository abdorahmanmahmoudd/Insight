//
//	ScoreData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ScoreData : NSObject, NSCoding{

	var category : String!
	var subCategory : String!
	var subSubCategory : [ScoreSubSubCategory]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		category = dictionary["category"] as? String
		subCategory = dictionary["sub_category"] as? String
		subSubCategory = [ScoreSubSubCategory]()
		if let subSubCategoryArray = dictionary["sub_sub_category"] as? [[String:Any]]{
			for dic in subSubCategoryArray{
				let value = ScoreSubSubCategory(fromDictionary: dic)
				subSubCategory.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if category != nil{
			dictionary["category"] = category
		}
		if subCategory != nil{
			dictionary["sub_category"] = subCategory
		}
		if subSubCategory != nil{
			var dictionaryElements = [[String:Any]]()
			for subSubCategoryElement in subSubCategory {
				dictionaryElements.append(subSubCategoryElement.toDictionary())
			}
			dictionary["sub_sub_category"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         category = aDecoder.decodeObject(forKey: "category") as? String
         subCategory = aDecoder.decodeObject(forKey: "sub_category") as? String
         subSubCategory = aDecoder.decodeObject(forKey :"sub_sub_category") as? [ScoreSubSubCategory]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if category != nil{
			aCoder.encode(category, forKey: "category")
		}
		if subCategory != nil{
			aCoder.encode(subCategory, forKey: "sub_category")
		}
		if subSubCategory != nil{
			aCoder.encode(subSubCategory, forKey: "sub_sub_category")
		}

	}

}