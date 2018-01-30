//
//	User.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class User : NSObject, NSCoding{

	var createdAt : String!
	var email : String!
	var governorate : String!
	var id : Int!
	var mobile : String!
	var name : String!
	var school : String!
	var updatedAt : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		createdAt = dictionary["created_at"] as? String
		email = dictionary["email"] as? String
		governorate = dictionary["governorate"] as? String
		id = dictionary["id"] as? Int
		mobile = dictionary["mobile"] as? String
		name = dictionary["name"] as? String
		school = dictionary["school"] as? String
		updatedAt = dictionary["updated_at"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if createdAt != nil{
			dictionary["created_at"] = createdAt
		}
		if email != nil{
			dictionary["email"] = email
		}
		if governorate != nil{
			dictionary["governorate"] = governorate
		}
		if id != nil{
			dictionary["id"] = id
		}
		if mobile != nil{
			dictionary["mobile"] = mobile
		}
		if name != nil{
			dictionary["name"] = name
		}
		if school != nil{
			dictionary["school"] = school
		}
		if updatedAt != nil{
			dictionary["updated_at"] = updatedAt
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
         email = aDecoder.decodeObject(forKey: "email") as? String
         governorate = aDecoder.decodeObject(forKey: "governorate") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         mobile = aDecoder.decodeObject(forKey: "mobile") as? String
         name = aDecoder.decodeObject(forKey: "name") as? String
         school = aDecoder.decodeObject(forKey: "school") as? String
         updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if createdAt != nil{
			aCoder.encode(createdAt, forKey: "created_at")
		}
		if email != nil{
			aCoder.encode(email, forKey: "email")
		}
		if governorate != nil{
			aCoder.encode(governorate, forKey: "governorate")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if mobile != nil{
			aCoder.encode(mobile, forKey: "mobile")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if school != nil{
			aCoder.encode(school, forKey: "school")
		}
		if updatedAt != nil{
			aCoder.encode(updatedAt, forKey: "updated_at")
		}

	}

}