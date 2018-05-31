//
//  MovieModel.swift
//  MovieApp
//
//  Created by webwerks on 27/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation
class Movie {
    var page:Int?
    var total_results:Int?
    var total_pages:Int?
    var dates:[String:String]?
    var results : [BaseModel]?
    
    init(jsonObject:[String:AnyObject]){
        if let bannersObj = jsonObject["results"] as? Array<[String : AnyObject]> {
            results = bannersObj.map{return BaseModel(jsonData: $0)}
        }
        page = jsonObject[APIMethodConstants.kPage] as? Int
        total_results = jsonObject[JsonResponseConstants.kTotalResults] as? Int
        total_pages = jsonObject[JsonResponseConstants.kTotalPages] as? Int
        dates = jsonObject[JsonResponseConstants.kDates] as? [String :String]
    }
   
}

