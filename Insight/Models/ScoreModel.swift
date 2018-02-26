//
//  ScoreModel.swift
//  Insight
//
//  Created by abdelrahman.youssef on 2/26/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import Foundation

class ScoreModel {
    
    static var UpdateScoreResource = Resource<UpdateScoreRootClass>.init(url: UpdateScoreURL, httpmethod: .post) { (json) -> UpdateScoreRootClass? in
        
        if let jsonObj = json as? [String : Any]
        {
            let content = UpdateScoreRootClass(fromDictionary: jsonObj)
            return content
        }
        return nil
    }
    
    static var GetScoreResource = Resource<GeneralResponse>.init(url: UpdateScoreURL, httpmethod: .get) { (json) -> GeneralResponse? in
        
        if let jsonObj = json as? [String : Any]
        {
            let content = GeneralResponse(fromDictionary: jsonObj)
            return content
        }
        return nil
    }
    
    func updateScore(score: CGFloat,category_id: String, sub_category_id: String, sub_sub_category_id: String, complation: @escaping (UpdateScoreRootClass?, Any?) -> (), errorHandler: @escaping (ErrorCode, Any?) -> () ){
        
        let sm = ServerManager()
        sm.httpConnect(resource: ScoreModel.UpdateScoreResource, paramters: ["score" : score , "category_id" : category_id,"sub_category_id": sub_category_id, "sub_sub_category_id": sub_sub_category_id ], authentication: UserModel.getInstance.getUser()?.token, AdditionalHeaders: ["version":appVersion], complation:
            { (json, data) in
                if let obj = json
                {
                    complation(obj, data)
                }
        })
        { (error, msg) in
            
            errorHandler(error, msg)
        }
    }
    
    func getScore( complation: @escaping (GeneralResponse?, Any?) -> (), errorHandler: @escaping (ErrorCode, Any?) -> () ){
        
        let sm = ServerManager()
        sm.httpConnect(resource: ScoreModel.GetScoreResource, paramters: nil, authentication: UserModel.getInstance.getUser()?.token, AdditionalHeaders: ["version":appVersion], complation:
            { (json, data) in
                if let obj = json
                {
                    complation(obj, data)
                }
        })
        { (error, msg) in
            
            errorHandler(error, msg)
        }
    }
}
