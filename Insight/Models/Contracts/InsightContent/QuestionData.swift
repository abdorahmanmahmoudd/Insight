//
//	Data.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class QuestionData : NSObject, NSCoding{

	var id : String!
	var answer : String!
	var content : String!
    var verb : String!
    var sound : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["_id"] as? String
		answer = dictionary["answer"] as? String
		content = dictionary["content"] as? String
        verb = dictionary["verb"] as? String
        sound = dictionary["sound"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if id != nil{
			dictionary["_id"] = id
		}
		if answer != nil{
			dictionary["answer"] = answer
		}
		if content != nil{
			dictionary["content"] = content
		}
        if verb != nil{
            dictionary["verb"] = verb
        }
        if sound != nil{
            dictionary["sound"] = sound
        }
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "_id") as? String
         answer = aDecoder.decodeObject(forKey: "answer") as? String
         content = aDecoder.decodeObject(forKey: "content") as? String
         verb = aDecoder.decodeObject(forKey: "verb") as? String
        sound = aDecoder.decodeObject(forKey: "sound") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "_id")
		}
		if answer != nil{
			aCoder.encode(answer, forKey: "answer")
		}
		if content != nil{
			aCoder.encode(content, forKey: "content")
		}
        if verb != nil{
            aCoder.encode(content, forKey: "verb")
        }
        if sound != nil{
            aCoder.encode(content, forKey: "sound")
        }

	}

}
