//
//	PromoCodeResponse.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class PromoCodeResponse : NSObject, NSCoding{

	var isValid : Bool!
    var msg : String!
	var promocode : Promocode!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		isValid = dictionary["isValid"] as? Bool
		if let promocodeData = dictionary["promocode"] as? [String:Any]{
			promocode = Promocode(fromDictionary: promocodeData)
		}
        msg = dictionary["msg"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if isValid != nil{
			dictionary["isValid"] = isValid
		}
		if promocode != nil{
			dictionary["promocode"] = promocode.toDictionary()
		}
        if msg != nil{
            dictionary["msg"] = msg
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         isValid = aDecoder.decodeObject(forKey: "isValid") as? Bool
         promocode = aDecoder.decodeObject(forKey: "promocode") as? Promocode
        msg = aDecoder.decodeObject(forKey: "msg") as? String
	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if isValid != nil{
			aCoder.encode(isValid, forKey: "isValid")
		}
		if promocode != nil{
			aCoder.encode(promocode, forKey: "promocode")
		}
        if msg != nil{
            aCoder.encode(msg, forKey: "msg")
        }

	}

}
