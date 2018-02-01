//
//	InsightContentRootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class InsightContentRootClass : NSObject, NSCoding{

	var id : Int!
	var name : String!
	var subCategory : [SubCategory]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
		subCategory = [SubCategory]()
		if let subCategoryArray = dictionary["sub_category"] as? [[String:Any]]{
			for dic in subCategoryArray{
				let value = SubCategory(fromDictionary: dic)
				subCategory.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
		if subCategory != nil{
			var dictionaryElements = [[String:Any]]()
			for subCategoryElement in subCategory {
				dictionaryElements.append(subCategoryElement.toDictionary())
			}
			dictionary["sub_category"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         subCategory = aDecoder.decodeObject(forKey :"sub_category") as? [SubCategory]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if subCategory != nil{
			aCoder.encode(subCategory, forKey: "sub_category")
		}

	}

}