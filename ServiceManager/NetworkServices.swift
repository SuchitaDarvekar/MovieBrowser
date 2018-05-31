//
//  NetworkServices.swift
//  MovieApp
//
//  Created by webwerks on 26/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation
import Alamofire

protocol INetworkServices {
    func get(_urlStr:String ,_parameters:[String : Any] ,complitHeader:@escaping (Result<Any>) -> Void)
    
}
public enum Result<Value> {
    
    case success(Value)
    case failure(Error)
    
  
    public var value: Value? {
        switch self {
        case .success(let value):
            return value
        case .failure:
            return nil
        }
    }
    
  
    public var error: Error? {
        switch self {
        case .success:
            return nil
        case .failure(let error):
            return error
        }
    }
}



class NetworkServices : INetworkServices {
    
    static var sharedInstance:NetworkServices = NetworkServices()
    
    func get(_urlStr: String, _parameters: [String : Any], complitHeader: @escaping (Result<Any>) -> Void) {
//        Alamofire.request(_urlStr, method: .get, parameters: _parameters, encoding: URLEncoding.default, headers: nil).response { response in
//
//            switch(response.data) {
//            case .success(_):
//                if let data = response.data{
//                 complitHeader(.success(data))
//                }
//                break
//
//            case .failure(_):
//               complitHeader(.success(response.result.error))
//            }
//        }
        
       Alamofire.request(_urlStr, method: .get, parameters: _parameters, encoding: URLEncoding.default, headers: nil).responseJSON { response in
            switch response.result {
            case .success(let data):
                if let resposeData = response.data{
                     print("Request data: \(resposeData)")
                  complitHeader(.success(data))
                }
            case .failure(let error):
                print("Request failed with error: \(error)")
                complitHeader(.success(response.result.error))
            }

//        Alamofire.request(_urlStr, method: .get, parameters: _parameters, encoding: URLEncoding.default, headers: nil).validate { request, response, data in
//            // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
//            return .success
//            }.response { response in
//
//                if let data = response.data{
//                    complitHeader(.success(data))
//                }
//        }
    }

    }
    
    
}


