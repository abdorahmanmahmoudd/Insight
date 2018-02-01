//
//	SubSubCategory.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class SubSubCategory : NSObject, NSCoding{

	var id : Int!
	var locked : Bool!
	var name : String!
	var questions : [Question]!
	var skip : Bool!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["id"] as? Int
		locked = dictionary["locked"] as? Bool
		name = dictionary["name"] as? String
		questions = [Question]()
		if let questionsArray = dictionary["questions"] as? [[String:Any]]{
			for dic in questionsArray{
				let value = Question(fromDictionary: dic)
				questions.append(value)
			}
		}
		skip = dictionary["skip"] as? Bool
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if id != nil{
			dictionary["id"] = id
		}
		if locked != nil{
			dictionary["locked"] = locked
		}
		if name != nil{
			dictionary["name"] = name
		}
		if questions != nil{
			var dictionaryElements = [[String:Any]]()
			for questionsElement in questions {
				dictionaryElements.append(questionsElement.toDictionary())
			}
			dictionary["questions"] = dictionaryElements
		}
		if skip != nil{
			dictionary["skip"] = skip
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         id = aDecoder.decodeObject(forKey: "id") as? Int
         locked = aDecoder.decodeObject(forKey: "locked") as? Bool
         name = aDecoder.decodeObject(forKey: "name") as? String
         questions = aDecoder.decodeObject(forKey :"questions") as? [Question]
         skip = aDecoder.decodeObject(forKey: "skip") as? Bool

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if locked != nil{
			aCoder.encode(locked, forKey: "locked")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
		if questions != nil{
			aCoder.encode(questions, forKey: "questions")
		}
		if skip != nil{
			aCoder.encode(skip, forKey: "skip")
		}

	}

}