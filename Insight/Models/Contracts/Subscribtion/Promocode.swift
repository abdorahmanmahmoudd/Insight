//
//	Promocode.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Promocode : NSObject, NSCoding{

	var discount : Int!
	var id : Int!
	var message : String!
	var newPrice : Int!
	var packageDurationId : Int!
	var packageId : Int!
	var price : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		discount = dictionary["discount"] as? Int
		id = dictionary["id"] as? Int
		message = dictionary["message"] as? String
		newPrice = dictionary["new_price"] as? Int
		packageDurationId = dictionary["package_duration_id"] as? Int
		packageId = dictionary["package_id"] as? Int
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
		if id != nil{
			dictionary["id"] = id
		}
		if message != nil{
			dictionary["message"] = message
		}
		if newPrice != nil{
			dictionary["new_price"] = newPrice
		}
		if packageDurationId != nil{
			dictionary["package_duration_id"] = packageDurationId
		}
		if packageId != nil{
			dictionary["package_id"] = packageId
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
         id = aDecoder.decodeObject(forKey: "id") as? Int
         message = aDecoder.decodeObject(forKey: "message") as? String
         newPrice = aDecoder.decodeObject(forKey: "new_price") as? Int
         packageDurationId = aDecoder.decodeObject(forKey: "package_duration_id") as? Int
         packageId = aDecoder.decodeObject(forKey: "package_id") as? Int
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
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if newPrice != nil{
			aCoder.encode(newPrice, forKey: "new_price")
		}
		if packageDurationId != nil{
			aCoder.encode(packageDurationId, forKey: "package_duration_id")
		}
		if packageId != nil{
			aCoder.encode(packageId, forKey: "package_id")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}

	}

}