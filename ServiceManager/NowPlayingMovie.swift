//
//  NowPlayingMovie.swift
//  MovieApp
//
//  Created by webwerks on 27/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation
protocol INowPlayingMovie {
    func getNowPlayingMoview(_methodName:String,_pageNo:Int,completionHandler:@escaping(Result<Any>)->Void)
}
class NowPlayingMovie: INowPlayingMovie {
    func getNowPlayingMoview(_methodName: String, _pageNo: Int, completionHandler: @escaping (Result<Any>) -> Void) {
        let url  = "\(APIConst.kBaseUrl)\(_methodName)"
        let network = NetworkServices.sharedInstance
        let parameter = [APIMethodConstants.kApiKey:APIConst.kApiKey,APIMethodConstants.kLanguage:APIMethodConstants.kUS_Eng,APIMethodConstants.kPage:_pageNo] as [String : Any]
        network.get(_urlStr: url, _parameters: parameter) { (result) in
            if let result = result.value,
                let response = result as? [String : AnyObject]{
                let movie = Movie(jsonObject: response)
                completionHandler(Result.success(movie))
            } else if let error = result.error {
                completionHandler(Result.failure(result.error!))
                print(error)
            }
        }
    }
    
   
}
