//
//	PackageRootClass.swift
//	Model file generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

import Foundation


class PackageRootClass : NSObject, NSCoding{

	var all : Bool!
	var id : Int!
	var name : String!
	var packagesDurations : [PackagesDuration]!
	var unlocked : [PackageUnlocked]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		all = dictionary["all"] as? Bool
		id = dictionary["id"] as? Int
		name = dictionary["name"] as? String
        packagesDurations = [PackagesDuration]()
        if let packagesDurationsArray = dictionary["packages_durations"] as? [[String:Any]]{
            for dic in packagesDurationsArray{
                let value = PackagesDuration(fromDictionary: dic)
                packagesDurations.append(value)
            }
        }
		unlocked = [PackageUnlocked]()
		if let unlockedArray = dictionary["unlocked"] as? [[String:Any]]{
			for dic in unlockedArray{
				let value = PackageUnlocked(fromDictionary: dic)
				unlocked.append(value)
			}
		}
	}

	/**
	 * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
	 */
	func toDictionary() -> [String:Any]
	{
		var dictionary = [String:Any]()
		if all != nil{
			dictionary["all"] = all
		}
		if id != nil{
			dictionary["id"] = id
		}
		if name != nil{
			dictionary["name"] = name
		}
        if packagesDurations != nil{
            var dictionaryElements = [[String:Any]]()
            for packagesDurationsElement in packagesDurations {
                dictionaryElements.append(packagesDurationsElement.toDictionary())
            }
            dictionary["packages_durations"] = dictionaryElements
        }
		if unlocked != nil{
			var dictionaryElements = [[String:Any]]()
			for unlockedElement in unlocked {
				dictionaryElements.append(unlockedElement.toDictionary())
			}
			dictionary["unlocked"] = dictionaryElements
		}
		return dictionary
	}

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
	{
         all = aDecoder.decodeObject(forKey: "all") as? Bool
         id = aDecoder.decodeObject(forKey: "id") as? Int
         name = aDecoder.decodeObject(forKey: "name") as? String
         packagesDurations = aDecoder.decodeObject(forKey :"packages_durations") as? [PackagesDuration]
         unlocked = aDecoder.decodeObject(forKey :"unlocked") as? [PackageUnlocked]

	}

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
	{
		if all != nil{
			aCoder.encode(all, forKey: "all")
		}
		if id != nil{
			aCoder.encode(id, forKey: "id")
		}
		if name != nil{
			aCoder.encode(name, forKey: "name")
		}
        if packagesDurations != nil{
            aCoder.encode(packagesDurations, forKey: "packages_durations")
        }
		if unlocked != nil{
			aCoder.encode(unlocked, forKey: "unlocked")
		}

	}

}
