//
//  ServerManager.swift
//  DHCC_iOS
//
//  Created by Ayman Ibrahim Abdel Alim on 12/4/16.
//  Copyright © 2016 LinkDev. All rights reserved.
//

import UIKit
import Alamofire

enum Models:Int
{
    case Xx = 1
}

enum ErrorCode:Int
{
    case Caneled = -999
    case NoInternet = -1009
    case UnKnown = 000
}

struct Resource<A>
{
    var url: String
    let httpmethod: Alamofire.HTTPMethod
    let parse: (Any) -> A?
}

class ServerManager: NSObject
{
    var request:DataRequest?
    //Authentication
    private var headers = ["Content-Type": "application/json", "Accept": "application/json"]
    //MARK: - HTTPHandling -
    func httpConnect<A>(resource:Resource<A>, paramters:[String:Any]?, authentication:String?,AdditionalHeaders : [String:String]? = [:] , complation: @escaping (A?, Any?) -> (), errorHandler: @escaping (ErrorCode, Any?) -> ()  )
    {
        
        let url = resource.url
        if let auth = authentication
        {
            headers["Authorization"] = "bearer \(auth)"
        }
        if AdditionalHeaders != nil {
            
            for header in AdditionalHeaders!{
                
                headers[header.key] = header.value
            }
        }
        request = Alamofire.request(url, method: resource.httpmethod, parameters: paramters, encoding: JSONEncoding.default, headers: headers).validate(statusCode: 200..<500).responseJSON
            { response in
                switch response.result
                {
                case .success:
                    let value = response.result.value
                    //print(value!)
                    let parse = resource.parse
                    let result = value.flatMap(parse)
                    DispatchQueue.main.async
                        {
                            complation(result, value)
                    }
                case .failure(let error):
                    //print(error._code)
                    print(error.localizedDescription)
                    DispatchQueue.main.async
                        {
                            if let errorEnum = ErrorCode(rawValue: error._code)
                            {
                                errorHandler(errorEnum, error)
                            }
                            else
                            {
                                errorHandler(ErrorCode(rawValue: 000)!, error)
                            }
                    }
                }
        }
    }
    
    func httpMultiPartFormConnect<A>(resource:Resource<A>, authentication : String?,AdditionalHeaders : [String:String]? = [:], paramters:[String:Any]?, mediaData: Data?, mediaMimeType : String, thumbnailData: Data? ,thumbMemiType: String = "image/jpeg", complation: @escaping (A?, Any?) -> (), errorHandler: @escaping (ErrorCode, Any?) -> ()  )
    {
        
        let url = resource.url
        if let auth = authentication
        {
            headers["Authorization"] = "bearer \(auth)"
        }
        if AdditionalHeaders != nil {
            
            for header in AdditionalHeaders!{
                
                headers[header.key] = header.value
            }
        }
        Alamofire.upload(multipartFormData: { (multiPartFormData) in
            
            if let params = paramters{
                for (key,val) in params{
                    multiPartFormData.append("\(val)".data(using: String.Encoding.utf8)!, withName: key)
                }
                if let data = mediaData{
                    
                    multiPartFormData.append(data, withName: "MediaFile", fileName: paramters!["FileName"] as! String, mimeType: mediaMimeType)
                }
            }
            if let data = thumbnailData {
                
                multiPartFormData.append(data, withName: "ThumbnailFile", fileName: paramters!["FileName"] as! String, mimeType: thumbMemiType)
            }
            
        }, to: url, method: resource.httpmethod, headers : headers ) { (encodedObject) in
            
            switch encodedObject {
                
            case .failure(let error):
                
                print(error.localizedDescription)
                DispatchQueue.main.async
                    {
                        if let errorEnum = ErrorCode(rawValue: error._code)
                        {
                            errorHandler(errorEnum, error)
                        }
                        else
                        {
                            errorHandler(ErrorCode(rawValue: 000)!, error)
                        }
                }
                
            case .success(request: let request, streamingFromDisk: _, streamFileURL: _ ):
                
                request.responseJSON(completionHandler:
                    
                    { (responseData) in
                        
                        let value = responseData.result.value
                        //print(value!)
                        let parse = resource.parse
                        let result = value.flatMap(parse)
                        DispatchQueue.main.async
                            {
                                complation(result, value)
                        }
                })
            }
        }
    }
    
    func cancelRequest()
    {
        if let cancellingReq = request
        {
            cancellingReq.cancel()
        }
    }
}
