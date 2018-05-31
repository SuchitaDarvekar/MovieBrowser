//
//  MovieDetailModel.swift
//  MovieApp
//
//  Created by webwerks on 27/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation

class MovieDeatilModel {
    var backdrop_path : String?
    var homepage : String?
    var id : Int?
    var title : String?
    var original_language : String?
    var popularity : Float?
    var poster_path : String?
    var revenue : Int?
    var status : String?
    var voteCount : Int?
    var tagline : String?
    var release_date :String?
    var overview:String?
    
    init(json:[String :AnyObject]) {
        backdrop_path = json[JsonResponseConstants.kBackdropPath] as? String
        homepage = json[JsonResponseConstants.kHomepage] as? String
        id = json[JsonResponseConstants.kId] as? Int
        title = json[JsonResponseConstants.kTitle] as? String
        original_language = json[JsonResponseConstants.kOriginalLanguage] as?String
        popularity = json[JsonResponseConstants.kPopularity] as? Float
        poster_path = json[JsonResponseConstants.kPosterPath] as? String
        revenue = json[JsonResponseConstants.kRevenue] as? Int
        status = json[JsonResponseConstants.kStatus] as? String
        voteCount = json[JsonResponseConstants.kVoteCount] as? Int
        tagline = json[JsonResponseConstants.kTagline] as? String
        release_date = json[JsonResponseConstants.kReleaseDate] as? String
        overview = json[JsonResponseConstants.kOverview] as? String

    }
    
}

