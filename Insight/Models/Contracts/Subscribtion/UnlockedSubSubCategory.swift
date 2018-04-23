//
//	UnlockedSubSubCategory.swift
//
//	Create by abdelrahman.youssef on 23/4/2018
//	Copyright © 2018. All rights reserved.
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class UnlockedSubSubCategory : NSObject, NSCoding{

	var subSubCategoryId : Int!
	var subSubCategoryName : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		subSubCategoryId = dictionary["sub_sub_category_id"] as? Int
		subSubCategoryName = dictionary["sub_sub_category_name"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if subSubCategoryId != nil{
			dictionary["sub_sub_category_id"] = subSubCategoryId
		}
		if subSubCategoryName != nil{
			dictionary["sub_sub_category_name"] = subSubCategoryName
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         subSubCategoryId = aDecoder.decodeObject(forKey: "sub_sub_category_id") as? Int
         subSubCategoryName = aDecoder.decodeObject(forKey: "sub_sub_category_name") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if subSubCategoryId != nil{
			aCoder.encode(subSubCategoryId, forKey: "sub_sub_category_id")
		}
		if subSubCategoryName != nil{
			aCoder.encode(subSubCategoryName, forKey: "sub_sub_category_name")
		}

	}

}