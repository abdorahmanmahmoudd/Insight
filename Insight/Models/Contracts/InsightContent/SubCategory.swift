//
//	SubCategory.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class SubCategory : NSObject, NSCoding{

	var id : Int!
	var locked : Bool!
	var name : String!
	var order : Int!
	var skip : Bool!
	var subSubCategory : [SubSubCategory]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["id"] as? Int
		locked = dictionary["locked"] as? Bool
		name = dictionary["name"] as? String
		order = dictionary["order"] as? Int
		skip = dictionary["skip"] as? Bool
		subSubCategory = [SubSubCategory]()
		if let subSubCategoryArray = dictionary["sub_sub_category"] as? [[String:Any]]{
			for dic in subSubCategoryArray{
				let value = SubSubCategory(fromDictionary: dic)
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
		if id != nil{
			dictionary["id"] = id
		}
		if locked != nil{
			dictionary["locked"] = locked
		}
		if name != nil{
			dictionary["name"] = name
		}
		if order != nil{
			dictionary["order"] = order
		}
		if skip != nil{
			dictionary["skip"] = skip
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
         id = aDecoder.decodeObject(forKey: "id") as? Int
         locked = aDecoder.decodeObject(forKey: "locked") as? Bool
         name = aDecoder.decodeObject(forKey: "name") as? String
         order = aDecoder.decodeObject(forKey: "order") as? Int
         skip = aDecoder.decodeObject(forKey: "skip") as? Bool
         subSubCategory = aDecoder.decodeObject(forKey :"sub_sub_category") as? [SubSubCategory]

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
		if locked != nil{
			aCoder.encode(locked, forKey: "locked")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if order != nil{
			aCoder.encode(order, forKey: "order")
		}
		if skip != nil{
			aCoder.encode(skip, forKey: "skip")
		}
		if subSubCategory != nil{
			aCoder.encode(subSubCategory, forKey: "sub_sub_category")
		}

	}

}