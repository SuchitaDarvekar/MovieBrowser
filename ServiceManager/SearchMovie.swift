//
//  SearchMovie.swift
//  MovieApp
//
//  Created by webwerks on 27/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation

protocol ISearchMovie {
    func searchMovieByQuery(_queryString:String,_page:Int,_methodName:String,completionHandler: @escaping(Result<Any>) ->Void)
}
class SearchMovie :ISearchMovie{
    func searchMovieByQuery(_queryString:String,_page:Int,_methodName:String,completionHandler: @escaping(Result<Any>)->Void){
        let url  = "\(APIConst.kBaseUrl)\(_methodName)"
        let network = NetworkServices.sharedInstance
        let parameter = [APIMethodConstants.kApiKey:APIConst.kApiKey,APIMethodConstants.kLanguage:APIMethodConstants.kUS_Eng,APIMethodConstants.kPage:_page,APIMethodConstants.kQuery:_queryString] as [String : Any]
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
