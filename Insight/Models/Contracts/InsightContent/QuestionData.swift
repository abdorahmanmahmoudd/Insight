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
    
    var choices : [Choice]!
    
    var place : String!
    var speakera : String!
    var speakerb : String!
    var functiona : String!
    var functionb : String!
    
    var mistakes : [Mistake]!
    
    var questions : [SubQuestion]!
    
    var answerContent : String!
    
    var freewriting : [Freewriting]!
    var mcq : [Mcq]!
    
    var adj : [DerivativeData]!
    var noun : [DerivativeData]!
    var dVerb : [DerivativeData]!


	/**
	 * Instantiate the instance using the passed dictionary values to set the properties values
	 */
	init(fromDictionary dictionary: [String:Any]){
		id = dictionary["_id"] as? String
		answer = dictionary["answer"] as? String
		content = dictionary["content"] as? String
        verb = dictionary["verb"] as? String
        sound = dictionary["sound"] as? String
        choices = [Choice]()
        if let choicesArray = dictionary["choices"] as? [[String:Any]]{
            for dic in choicesArray{
                let value = Choice(fromDictionary: dic)
                choices.append(value)
            }
        }
        place = dictionary["place"] as? String
        speakera = dictionary["speakera"] as? String
        speakerb = dictionary["speakerb"] as? String
        functiona = dictionary["functiona"] as? String
        functionb = dictionary["functionb"] as? String
        mistakes = [Mistake]()
        if let mistakesArray = dictionary["mistakes"] as? [[String:Any]]{
            for dic in mistakesArray{
                let value = Mistake(fromDictionary: dic)
                mistakes.append(value)
            }
        }
        
        questions = [SubQuestion]()
        if let questionsArray = dictionary["questions"] as? [[String:Any]]{
            for dic in questionsArray{
                let value = SubQuestion(fromDictionary: dic)
                questions.append(value)
            }
        }
        
        answerContent = dictionary["answerContent"] as? String
        
        freewriting = [Freewriting]()
        if let freewritingArray = dictionary["freewriting"] as? [[String:Any]]{
            for dic in freewritingArray{
                let value = Freewriting(fromDictionary: dic)
                freewriting.append(value)
            }
        }
        mcq = [Mcq]()
        if let mcqArray = dictionary["mcq"] as? [[String:Any]]{
            for dic in mcqArray{
                let value = Mcq(fromDictionary: dic)
                mcq.append(value)
            }
        }
        
        adj = [DerivativeData]()
        if let adjArray = dictionary["adj"] as? [[String:Any]]{
            for dic in adjArray{
                let value = DerivativeData(fromDictionary: dic)
                adj.append(value)
            }
        }
        noun = [DerivativeData]()
        if let nounArray = dictionary["noun"] as? [[String:Any]]{
            for dic in nounArray{
                let value = DerivativeData(fromDictionary: dic)
                noun.append(value)
            }
        }
        dVerb = [DerivativeData]()
        if let verbArray = dictionary["verb"] as? [[String:Any]]{
            for dic in verbArray{
                let value = DerivativeData(fromDictionary: dic)
                dVerb.append(value)
            }
        }
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
        if choices != nil{
            var dictionaryElements = [[String:Any]]()
            for choicesElement in choices {
                dictionaryElements.append(choicesElement.toDictionary())
            }
            dictionary["choices"] = dictionaryElements
        }
        if place != nil{
            dictionary["place"] = place
        }
        if speakera != nil{
            dictionary["speakera"] = speakera
        }
        if speakerb != nil{
            dictionary["speakerb"] = speakerb
        }
        if functiona != nil{
            dictionary["functiona"] = functiona
        }
        if functionb != nil{
            dictionary["functionb"] = functionb
        }
        if mistakes != nil{
            var dictionaryElements = [[String:Any]]()
            for mistakesElement in mistakes {
                dictionaryElements.append(mistakesElement.toDictionary())
            }
            dictionary["mistakes"] = dictionaryElements
        }
        
        if questions != nil{
            var dictionaryElements = [[String:Any]]()
            for questionsElement in questions {
                dictionaryElements.append(questionsElement.toDictionary())
            }
            dictionary["questions"] = dictionaryElements
        }
        
        if answerContent != nil{
            dictionary["answerContent"] = answerContent
        }
        
        if freewriting != nil{
            var dictionaryElements = [[String:Any]]()
            for freewritingElement in freewriting {
                dictionaryElements.append(freewritingElement.toDictionary())
            }
            dictionary["freewriting"] = dictionaryElements
        }
        if mcq != nil{
            var dictionaryElements = [[String:Any]]()
            for mcqElement in mcq {
                dictionaryElements.append(mcqElement.toDictionary())
            }
            dictionary["mcq"] = dictionaryElements
        }
        if adj != nil{
            var dictionaryElements = [[String:Any]]()
            for adjElement in adj {
                dictionaryElements.append(adjElement.toDictionary())
            }
            dictionary["adj"] = dictionaryElements
        }
        if noun != nil{
            var dictionaryElements = [[String:Any]]()
            for nounElement in noun {
                dictionaryElements.append(nounElement.toDictionary())
            }
            dictionary["noun"] = dictionaryElements
        }
        if dVerb != nil{
            var dictionaryElements = [[String:Any]]()
            for verbElement in dVerb {
                dictionaryElements.append(verbElement.toDictionary())
            }
            dictionary["verb"] = dictionaryElements
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
        choices = aDecoder.decodeObject(forKey :"choices") as? [Choice]
        place = aDecoder.decodeObject(forKey: "place") as? String
        speakera = aDecoder.decodeObject(forKey: "speakera") as? String
        speakerb = aDecoder.decodeObject(forKey: "speakerb") as? String
        functiona = aDecoder.decodeObject(forKey: "functiona") as? String
        functionb = aDecoder.decodeObject(forKey: "functionb") as? String
        mistakes = aDecoder.decodeObject(forKey :"mistakes") as? [Mistake]
        questions = aDecoder.decodeObject(forKey :"questions") as? [SubQuestion]
        answerContent = aDecoder.decodeObject(forKey :"answerContent") as? String
        freewriting = aDecoder.decodeObject(forKey :"freewriting") as? [Freewriting]
        mcq = aDecoder.decodeObject(forKey :"mcq") as? [Mcq]
        adj = aDecoder.decodeObject(forKey :"adj") as? [DerivativeData]
        noun = aDecoder.decodeObject(forKey :"noun") as? [DerivativeData]
        dVerb = aDecoder.decodeObject(forKey :"verb") as? [DerivativeData]
        
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
            aCoder.encode(verb, forKey: "verb")
        }
        if sound != nil{
            aCoder.encode(sound, forKey: "sound")
        }
        if choices != nil{
            aCoder.encode(choices, forKey: "choices")
        }
        if place != nil{
            aCoder.encode(place, forKey: "place")
        }
        if speakera != nil{
            aCoder.encode(speakera, forKey: "speakera")
        }
        if speakerb != nil{
            aCoder.encode(speakerb, forKey: "speakerb")
        }
        if functiona != nil{
            aCoder.encode(functiona, forKey: "functiona")
        }
        if functionb != nil{
            aCoder.encode(functionb, forKey: "functionb")
        }
        if mistakes != nil{
            aCoder.encode(mistakes, forKey: "mistakes")
        }
        if questions != nil{
            aCoder.encode(questions, forKey: "questions")
        }
        if answerContent != nil{
            aCoder.encode(answerContent, forKey: "answerContent")
        }
        if freewriting != nil{
            aCoder.encode(freewriting, forKey: "freewriting")
        }
        if mcq != nil{
            aCoder.encode(mcq, forKey: "mcq")
        }
        if adj != nil{
            aCoder.encode(adj, forKey: "adj")
        }
        if noun != nil{
            aCoder.encode(noun, forKey: "noun")
        }
        if dVerb != nil{
            aCoder.encode(verb, forKey: "verb")
        }

	}

}
