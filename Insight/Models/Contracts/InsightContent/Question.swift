//
//	Question.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class Question : NSObject, NSCoding{

	var data : [QuestionData]!
	var id : Int!
	var title : String!
	var type : String!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		data = [QuestionData]()
		if let dataArray = dictionary["data"] as? [[String:Any]]{
			for dic in dataArray{
				let value = QuestionData(fromDictionary: dic)
				data.append(value)
			}
		}
		id = dictionary["id"] as? Int
		title = dictionary["title"] as? String
		type = dictionary["type"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if data != nil{
			var dictionaryElements = [[String:Any]]()
			for dataElement in data {
				dictionaryElements.append(dataElement.toDictionary())
			}
			dictionary["data"] = dictionaryElements
		}
		if id != nil{
			dictionary["id"] = id
		}
		if title != nil{
			dictionary["title"] = title
		}
		if type != nil{
			dictionary["type"] = type
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         data = aDecoder.decodeObject(forKey :"data") as? [QuestionData]
         id = aDecoder.decodeObject(forKey: "id") as? Int
         title = aDecoder.decodeObject(forKey: "title") as? String
         type = aDecoder.decodeObject(forKey: "type") as? String

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
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if title != nil{
			aCoder.encode(title, forKey: "title")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}

	}

}
