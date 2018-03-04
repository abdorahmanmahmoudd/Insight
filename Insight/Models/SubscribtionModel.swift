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
    
    func getPackages(complation: @escaping ([PackageRootClass], Any?) -> (), errorHandler: @escaping (ErrorCode, Any?) -> () ){
        
        let sm = ServerManager()
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
}
