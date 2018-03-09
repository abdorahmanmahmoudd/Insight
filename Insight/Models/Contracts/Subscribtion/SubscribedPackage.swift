//
//	SubscribedPackage.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class SubscribedPackage : NSObject, NSCoding{

	var email : String!
	var mobile : String!
	var orderId : Int!
	var packageName : String!
	var price : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		email = dictionary["email"] as? String
		mobile = dictionary["mobile"] as? String
		orderId = dictionary["orderId"] as? Int
		packageName = dictionary["packageName"] as? String
		price = dictionary["price"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if email != nil{
			dictionary["email"] = email
		}
		if mobile != nil{
			dictionary["mobile"] = mobile
		}
		if orderId != nil{
			dictionary["orderId"] = orderId
		}
		if packageName != nil{
			dictionary["packageName"] = packageName
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
         email = aDecoder.decodeObject(forKey: "email") as? String
         mobile = aDecoder.decodeObject(forKey: "mobile") as? String
         orderId = aDecoder.decodeObject(forKey: "orderId") as? Int
         packageName = aDecoder.decodeObject(forKey: "packageName") as? String
         price = aDecoder.decodeObject(forKey: "price") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if mobile != nil{
			aCoder.encode(mobile, forKey: "mobile")
		}
		if orderId != nil{
			aCoder.encode(orderId, forKey: "orderId")
		}
		if packageName != nil{
			aCoder.encode(packageName, forKey: "packageName")
		}
		if price != nil{
			aCoder.encode(price, forKey: "price")
		}

	}

}