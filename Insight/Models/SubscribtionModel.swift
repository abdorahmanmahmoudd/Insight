//
//  SubscribtionModel.swift
//  Insight
//
//  Created by abdelrahman.youssef on 3/4/18.
//  Copyright © 2018 ClueApps. All rights reserved.
//

import Foundation

class SubscribtionModel{
    
    static var GetPackagesResource = Resource<[PackageRootClass]>.init(url: GetPackagesURL, httpmethod: .get) { (json) -> [PackageRootClass] in
        
        var pkgs = [PackageRootClass]()
        if let jsonObj = json as? [[String : Any]]
        {
            for obj in jsonObj{
                let pkg = PackageRootClass(fromDictionary: obj)
                pkgs.append(pkg)
            }
        }
        return pkgs
    }
    
    static var ValidateCodeResource = Resource<PromoCodeResponse>.init(url: ValidateCodeURL, httpmethod: .get) { (json) -> PromoCodeResponse? in
        
        if let jsonObj = json as? [String : Any]
        {
            let content = PromoCodeResponse(fromDictionary: jsonObj)
            return content
        }
        return nil
    }
    
    static var SubscribeToPackageResource = Resource<SubscribedPackageResponse>.init(url: CreatePackageURL, httpmethod: .post) { (json) -> SubscribedPackageResponse? in
        
        if let jsonObj = json as? [String :Any]
        {
            let content = SubscribedPackageResponse.init(fromDictionary: jsonObj)
            return content
        }
        return nil
    }
    
    func getPackages(complation: @escaping ([PackageRootClass], Any?) -> (), errorHandler: @escaping (ErrorCode, Any?) -> () ){
        
        let sm = ServerManager()
        SubscribtionModel.GetPackagesResource.url = GetPackagesURL
        sm.httpConnect(resource: SubscribtionModel.GetPackagesResource, paramters: nil, authentication: UserModel.getInstance.getUser()?.token, AdditionalHeaders: ["version":appVersion], complation:
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
    
    
    func getUserPackages(complation: @escaping ([PackageRootClass], Any?) -> (), errorHandler: @escaping (ErrorCode, Any?) -> () ){
        
        let sm = ServerManager()
        SubscribtionModel.GetPackagesResource.url = GetUserPackagesURL
        sm.httpConnect(resource: SubscribtionModel.GetPackagesResource, paramters: nil, authentication: UserModel.getInstance.getUser()?.token, AdditionalHeaders: ["version":appVersion], complation:
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
    
    func validateCode(code: String, complation: @escaping (PromoCodeResponse, Any?) -> (), errorHandler: @escaping (ErrorCode, Any?) -> () ){
        
        let sm = ServerManager()
        SubscribtionModel.ValidateCodeResource.url += code
        sm.httpConnect(resource: SubscribtionModel.ValidateCodeResource, paramters: nil, authentication: UserModel.getInstance.getUser()?.token, AdditionalHeaders: ["version":appVersion], complation:
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
    
    
    func CreateUserPackage(type: String, id: String, complation: @escaping (SubscribedPackageResponse, Any?) -> (), errorHandler: @escaping (ErrorCode, Any?) -> () ){
        
        let sm = ServerManager()
        sm.httpConnect(resource: SubscribtionModel.SubscribeToPackageResource, paramters: ["type": type, "id": id], authentication: UserModel.getInstance.getUser()?.token, AdditionalHeaders: ["version":appVersion], complation:
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
