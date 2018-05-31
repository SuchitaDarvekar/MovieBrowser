//
//  SimilarMovies.swift
//  MovieApp
//
//  Created by webwerks on 29/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation
protocol ISimilarMovies {
    func getSimilarMoviesFor(_methodNAme:String,page:Int,completionHandler:@escaping(Result<Any?>)->Void)
}
class SimilarMovies : ISimilarMovies{
     func getSimilarMoviesFor(_methodNAme:String,page:Int,completionHandler:@escaping(Result<Any?>)->Void){
        let url  = "\(APIConst.kBaseUrl)\(_methodNAme)"
        let network = NetworkServices.sharedInstance
        let parameter = [APIMethodConstants.kApiKey:APIConst.kApiKey,APIMethodConstants.kLanguage:APIMethodConstants.kUS_Eng,APIMethodConstants.kPage:page] as [String : Any]
        network.get(_urlStr: url, _parameters: parameter) { (result) in
            print(result)
            if let result = result.value,
                let response = result as? [String : AnyObject]{
                let searchResult = SearchModel(jsonObject: response)
                completionHandler(Result.success(searchResult))
            } else if let error = result.error {
                completionHandler(Result.failure(result.error!))
                print(error)
            }
        }
    }
    
}
