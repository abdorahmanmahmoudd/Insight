//
//  UserModel.swift
//  MedicalDoctor
//
//  Created by abdelrahman.youssef on 1/27/18.
//  Copyright © 2018 HyperDesign. All rights reserved.
//

import Foundation

class UserModel {
    
    static let getInstance = UserModel()
    
    func saveUser(_ user : AuthRootClass) {
        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: user)
        UserDefaults.standard.set(encodedObject, forKey: UserCredentials)
        UserDefaults.standard.synchronize()
    }
    
    
    func getUser() -> AuthRootClass?  {
        let data = UserDefaults.standard.data(forKey: UserCredentials)
        if data != nil
        {
            let obj = NSKeyedUnarchiver.unarchiveObject(with: data!)
            return obj as? AuthRootClass
        }
        return nil
    }
    
    func deleteUserCredentials()
    {
        UserDefaults.standard.removeObject(forKey: UserCredentials)
        UserDefaults.standard.synchronize()
    }
    
//    func saveUserToken(token: String) { // firebase token
//        UserDefaults.standard.set(token, forKey: tokenKey)
//        UserDefaults.standard.synchronize()
//    }
//
//    func getUserToken() -> String{ // firebase token
//        return UserDefaults.standard.value(forKey: tokenKey) as? String ?? ""
//    }
    
//    static var LoginResource = Resource<AuthRootClass>.init(url: LoginURL, httpmethod: .post) { (json) -> AuthRootClass? in
//
//        if let jsonObj = json as? [String : Any]
//        {
//            let content = LoginRootClass(fromDictionary: jsonObj)
//            return content
//        }
//        return nil
//    }
    
    static var AuthResource = Resource<AuthRootClass>.init(url: SignUpURL, httpmethod: .post) { (json) -> AuthRootClass? in
        
        if let jsonObj = json as? [String : Any]
        {
            let content = AuthRootClass(fromDictionary: jsonObj)
            return content
        }
        return nil
    }
    
    func SignIn(phone: String, pass: String, complation: @escaping (AuthRootClass?, Any?) -> (), errorHandler: @escaping (ErrorCode, Any?) -> ()){
        
        let sm = ServerManager()
        UserModel.AuthResource.url = SignInURL
        sm.httpConnect(resource: UserModel.AuthResource, paramters: ["mobile" : phone , "password" : pass,"device_id": UIDevice.current.identifierForVendor?.uuidString, "platform": "ios" ], authentication: nil, AdditionalHeaders: ["version":appVersion], complation:
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
    
    func SignUp(name: String, mobile: String, pass: String, governorate: String, school: String, email: String, complation: @escaping (AuthRootClass?, Any?) -> (), errorHandler: @escaping (ErrorCode, Any?) -> ()){
        
        let sm = ServerManager()
        UserModel.AuthResource.url = SignUpURL
        sm.httpConnect(resource: UserModel.AuthResource, paramters: ["name" : name , "mobile" : mobile , "password" : pass , "governorate" : governorate, "school" : school ,"email" : email, "device_id": UIDevice.current.identifierForVendor?.uuidString, "platform": "ios" ], authentication: nil, AdditionalHeaders: ["version":appVersion], complation:
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
    
    func ForgetPassword(email: String, complation: @escaping (AuthRootClass?, Any?) -> (), errorHandler: @escaping (ErrorCode, Any?) -> ()){
        
        let sm = ServerManager()
        sm.httpConnect(resource: UserModel.AuthResource, paramters: ["email" : email], authentication: nil, complation:
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
    
    func editProfile(name: String, phone: String, govern: String, email: String, school: String, complation: @escaping (GeneralResponse?, Any?) -> (), errorHandler: @escaping (ErrorCode, Any?) -> ()){
        
        let sm = ServerManager()
        let editProfileResource = Resource<GeneralResponse>.init(url: EditProfileURL, httpmethod: .put) { (json) -> GeneralResponse? in
            
            if let jsonObj = json as? [String : Any]
            {
                let content = GeneralResponse(fromDictionary: jsonObj)
                return content
            }
            return nil
        }
        sm.httpConnect(resource: editProfileResource, paramters: ["name": name,
            "mobile": phone,"governorate": govern,"email": email,
            "school": school ], authentication: UserModel.getInstance.getUser()?.token,AdditionalHeaders: ["version": appVersion], complation:
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
    
    
    func changePassword(current: String, new: String,  complation: @escaping (GeneralResponse?, Any?) -> (), errorHandler: @escaping (ErrorCode, Any?) -> ()){
        
        let sm = ServerManager()
        let changePassResource = Resource<GeneralResponse>.init(url: ChangePasswordURL, httpmethod: .put) { (json) -> GeneralResponse? in
            
            if let jsonObj = json as? [String : Any]
            {
                let content = GeneralResponse(fromDictionary: jsonObj)
                return content
            }
            return nil
        }
        sm.httpConnect(resource: changePassResource, paramters: ["oldPassword": current,"newPassword": new ], authentication: UserModel.getInstance.getUser()?.token,AdditionalHeaders: ["version": appVersion], complation:
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
