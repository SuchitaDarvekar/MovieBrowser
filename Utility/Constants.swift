//
//  Constants.swift
//  MovieApp
//
//  Created by webwerks on 27/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation
struct APIMethodConstants {
   static let kNowPlaying = "/movie/now_playing"
   static let kMoviePopular = "/movie/popular"
   static let kMovieToprated = "/movie/top_rated"
   static let KMovieUpcoming = "/movie/upcoming"
   static let kSearchMovie = "/search/movie"
   static let kMovieDetail = "/movie/"
   static let kLanguage = "language"
   static let kUS_Eng = "en-US"
   static let kPage = "page"
   static let kQuery = "query"
   static let kApiKey = "api_key"
   static let kSimilar = "/similar"
}
 struct APIConst{
    static let kBaseUrl = "https://api.themoviedb.org/3"
    static let kApiKey = "acc52c75524662aac0f39805edd161f5"
    static let kMoviePosterImgURL = "https://image.tmdb.org/t/p/w185"
    static let kBannerURL = "https://image.tmdb.org/t/p/w780"
}

struct JsonResponseConstants {
    //// get now playing ///
    static let kPosterPath = "poster_path"
    static let kVoteCount = "vote_count"
    static let kId = "id"
    static let kVideo = "video"
    static let kVoteAverage = "vote_average"
    static let kTitle = "title"
    static let kPopularity = "popularity"
    static let kOriginalLanguage = "original_language"
    static let kOriginalTitle = "original_title"
    static let kGenreIds = "genre_ids"
    static let kBackdropPath = "backdrop_path"
    static let kAdult = "adult"
    static let kOverview = "overview"
    static let kTotalResults = "total_results"
    static let kDates = "dates"
    static let kMaximum = "maximum"
    static let kMinimum = "minimum"
    static let kTotalPages = "total_pages"
    static let kReleaseDate = "release_date"
    
    //// get deatails
    static let kBelongsToCollection = "belongs_to_collection"
    static let kName = "name"
    static let kHomepage = "homepage"
    static let kimdbId = "imdb_id"
    static let kLogoPath = "logo_path"
    static let kSpokenLanguages = "spoken_languages"
    static let kRuntime = "runtime"
    static let kRevenue = "revenue"
    static let kStatus = "status"
    static let kTagline = "tagline"
    static let kOriginCountry = "origin_country"
    static let kiso_3166_1 = "iso_3166_1"
   }

struct ViewConst {
    static let kSearchTblCell = "searchTblCell"
    static let knowPlayingCell = "nowPlayingCell"
    static let kComingSoonCell = "comingSoonCell"
    static let kDeatilcollCell = "DeatilcollCell"
    static let ksimilarMovieCell = "similarMovieCell"
    static let kfilterTblCell = "filterTblCell"
}

struct Messages {
    static let kNoInternet = "No internet connection please try again later."
}

