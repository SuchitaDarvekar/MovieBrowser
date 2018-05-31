//
//  GetMovie.swift
//  MovieApp
//
//  Created by webwerks on 27/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation

protocol IGetMovieDetails {
    func getMovieDeatilForMovieID(_methodName:String, completionHandler:@escaping(Result<Any?>) -> Void)
}
class GetMovieDetails:IGetMovieDetails{

    func getMovieDeatilForMovieID(_methodName: String ,completionHandler:@escaping(Result<Any?>) -> Void) {
        let network = NetworkServices.sharedInstance
        let parameter = [APIMethodConstants.kApiKey:APIConst.kApiKey]
        let url = "\(APIConst.kBaseUrl)\(_methodName)"
        network.get(_urlStr: url, _parameters: parameter) { (result) in
            if let result  = result.value , let response = result as? [String:AnyObject] {
                let movieDetail = MovieDeatilModel(json: response)
                completionHandler(Result.success(movieDetail))
            }else if let error = result.error {
                completionHandler(Result.failure(error))
            }
        }
    }
    
}
