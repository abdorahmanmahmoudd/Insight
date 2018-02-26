//
//	UpdateScoreRootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class UpdateScoreRootClass : NSObject, NSCoding{

	var data : UpdateScoreData!
	var isSuccess : Bool!
	var message : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		if let dataData = dictionary["data"] as? [String:Any]{
			data = UpdateScoreData(fromDictionary: dataData)
		}
		isSuccess = dictionary["isSuccess"] as? Bool
		message = dictionary["message"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if data != nil{
			dictionary["data"] = data.toDictionary()
		}
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
         data = aDecoder.decodeObject(forKey: "data") as? UpdateScoreData
         isSuccess = aDecoder.decodeObject(forKey: "isSuccess") as? Bool
         message = aDecoder.decodeObject(forKey: "message") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if data != nil{
			aCoder.encode(data, forKey: "data")
		}
		if isSuccess != nil{
			aCoder.encode(isSuccess, forKey: "isSuccess")
		}
		if message != nil{
			aCoder.encode(message, forKey: "message")
		}

	}

}