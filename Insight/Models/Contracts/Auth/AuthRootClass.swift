//
//	AuthRootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class AuthRootClass : NSObject, NSCoding{

	var token : String!
	var user : User!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		token = dictionary["token"] as? String
		if let userData = dictionary["user"] as? [String:Any]{
			user = User(fromDictionary: userData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if token != nil{
			dictionary["token"] = token
		}
		if user != nil{
			dictionary["user"] = user.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         token = aDecoder.decodeObject(forKey: "token") as? String
         user = aDecoder.decodeObject(forKey: "user") as? User

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if token != nil{
			aCoder.encode(token, forKey: "token")
		}
		if user != nil{
			aCoder.encode(user, forKey: "user")
		}

	}

}