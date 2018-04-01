//
//	ScoreSubSubCategory.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class ScoreSubSubCategory : NSObject, NSCoding{

	var averageScore : Float!
	var name : String!
	var scores : [Int]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		averageScore = dictionary["averageScore"] as? Float
		name = dictionary["name"] as? String
		scores = dictionary["scores"] as? [Int]
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if averageScore != nil{
			dictionary["averageScore"] = averageScore
		}
		if name != nil{
			dictionary["name"] = name
		}
		if scores != nil{
			dictionary["scores"] = scores
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         averageScore = aDecoder.decodeObject(forKey: "averageScore") as? Float
         name = aDecoder.decodeObject(forKey: "name") as? String
         scores = aDecoder.decodeObject(forKey: "scores") as? [Int]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if averageScore != nil{
			aCoder.encode(averageScore, forKey: "averageScore")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if scores != nil{
			aCoder.encode(scores, forKey: "scores")
		}

	}

}