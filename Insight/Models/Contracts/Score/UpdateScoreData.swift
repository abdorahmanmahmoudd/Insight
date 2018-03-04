//
//	UpdateScoreData.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class UpdateScoreData : NSObject, NSCoding{

	var average : String!
	var score : Int!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		average = dictionary["average"] as? String
		score = dictionary["score"] as? Int
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if average != nil{
			dictionary["average"] = average
		}
		if score != nil{
			dictionary["score"] = score
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         average = aDecoder.decodeObject(forKey: "average") as? String
         score = aDecoder.decodeObject(forKey: "score") as? Int

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if average != nil{
			aCoder.encode(average, forKey: "average")
		}
		if score != nil{
			aCoder.encode(score, forKey: "score")
		}

	}

}