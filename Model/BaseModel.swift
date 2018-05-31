//
//  BaseModel.swift
//  MovieApp
//
//  Created by webwerks on 27/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation
class BaseModel {
    var vote_count:Int?
    var id:Int?
    var video:Bool?
    var vote_average:Int?
    var title:String?
    var popularity:Float?
    var poster_path:String?
    var original_language:String?
    var original_title:String?
    var genre_ids :[Int]?
    var backdrop_path:String?
    var adult : Bool?
    var overview:String?
    var release_date : String?
    
    init(jsonData:[String:Any]){
        vote_count = jsonData[JsonResponseConstants.kVoteCount] as? Int
        id = jsonData[JsonResponseConstants.kId] as? Int
        video = jsonData[JsonResponseConstants.kVideo] as? Bool
        vote_average = jsonData[JsonResponseConstants.kVoteAverage] as? Int
        title = jsonData[JsonResponseConstants.kTitle] as? String
        popularity = jsonData[JsonResponseConstants.kPopularity] as? Float
        poster_path = jsonData[JsonResponseConstants.kPosterPath ] as? String
        original_language = jsonData[JsonResponseConstants.kOriginalLanguage] as? String
        genre_ids = jsonData[JsonResponseConstants.kGenreIds] as? Array
         backdrop_path = jsonData[JsonResponseConstants.kBackdropPath] as? String
         adult = jsonData[JsonResponseConstants.kAdult] as? Bool
         overview = jsonData[JsonResponseConstants.kOverview] as? String
         release_date = jsonData[JsonResponseConstants.kReleaseDate] as? String
        
        
    }
}

