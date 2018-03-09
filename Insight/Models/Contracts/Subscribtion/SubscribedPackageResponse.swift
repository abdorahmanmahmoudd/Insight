//
//	SubscribedPackageResponse.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class SubscribedPackageResponse : NSObject, NSCoding{

	var isSuccess : Bool!
	var message : String!
	var packageField : SubscribedPackage!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		isSuccess = dictionary["isSuccess"] as? Bool
		message = dictionary["message"] as? String
		if let packageFieldData = dictionary["package"] as? [String:Any]{
			packageField = SubscribedPackage(fromDictionary: packageFieldData)
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if isSuccess != nil{
			dictionary["isSuccess"] = isSuccess
		}
		if message != nil{
			dictionary["message"] = message
		}
		if packageField != nil{
			dictionary["package"] = packageField.toDictionary()
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         isSuccess = aDecoder.decodeObject(forKey: "isSuccess") as? Bool
         message = aDecoder.decodeObject(forKey: "message") as? String
         packageField = aDecoder.decodeObject(forKey: "package") as? SubscribedPackage

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if isSuccess != nil{
			aCoder.encode(isSuccess, forKey: "isSuccess")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}
		if packageField != nil{
			aCoder.encode(packageField, forKey: "package")
		}

	}

}