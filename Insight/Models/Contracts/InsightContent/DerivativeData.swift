//
//	Adj.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class DerivativeData : NSObject, NSCoding{

    var content : String!
	var type : String!
    var underLinedWord : NSAttributedString?{
        
        get{
            
            var tempValue : NSAttributedString? =  NSAttributedString.init(string: "-")
            let tempContent = content.html2AttributedString
             tempContent?.enumerateAttribute(NSAttributedStringKey.underlineStyle, in: NSMakeRange(0, tempContent?.length ?? 0), options: NSAttributedString.EnumerationOptions.longestEffectiveRangeNotRequired, using: { (attribute, range, pointer) in
                
                if attribute != nil {
                    tempValue = tempContent?.attributedSubstring(from: range)
                }
            })
            return tempValue
        }
    }


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		content = dictionary["content"] as? String
		type = dictionary["type"] as? String
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if content != nil{
			dictionary["content"] = content
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
         content = aDecoder.decodeObject(forKey: "content") as? String
         type = aDecoder.decodeObject(forKey: "type") as? String

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if content != nil{
			aCoder.encode(content, forKey: "content")
		}
		if type != nil{
			aCoder.encode(type, forKey: "type")
		}

	}

}
