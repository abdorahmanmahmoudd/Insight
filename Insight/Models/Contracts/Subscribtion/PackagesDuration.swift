//
//	PackagesDuration.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class PackagesDuration : NSObject, NSCoding{

	var discount : Int!
	var duration : Int!
	var id : Int!
	var price : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		discount = dictionary["discount"] as? Int
		duration = dictionary["duration"] as? Int
		id = dictionary["id"] as? Int
		price = dictionary["price"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if discount != nil{
			dictionary["discount"] = discount
		}
		if duration != nil{
			dictionary["duration"] = duration
		}
		if id != nil{
			dictionary["id"] = id
		}
		if price != nil{
			dictionary["price"] = price
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         discount = aDecoder.decodeObject(forKey: "discount") as? Int
         duration = aDecoder.decodeObject(forKey: "duration") as? Int
         id = aDecoder.decodeObject(forKey: "id") as? Int
         price = aDecoder.decodeObject(forKey: "price") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if discount != nil{
			aCoder.encode(discount, forKey: "discount")
		}
		if duration != nil{
			aCoder.encode(duration, forKey: "duration")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}

	}

}