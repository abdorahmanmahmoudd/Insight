//
//	ChangePasswordResponse .swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class GeneralResponse  : NSObject, NSCoding{

	var isSuccess : Bool!
	var message : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		isSuccess = dictionary["isSuccess"] as? Bool
		message = dictionary["message"] as? String
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

	}

}
