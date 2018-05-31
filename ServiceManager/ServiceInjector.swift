//
//  ServiceInjector.swift
//  MovieApp
//
//  Created by webwerks on 27/05/18.
//  Copyright © 2018 webwerks. All rights reserved.
//

import Foundation


class ServiceInjector {
    static var sharedInstance:ServiceInjector = ServiceInjector()
    func searchMovie() ->ISearchMovie{
      return SearchMovie()
   }
    func getMovieDatils() -> IGetMovieDetails {
        return GetMovieDetails()
    }
    
    func getMovieList() -> INowPlayingMovie{
        return NowPlayingMovie()
    }
    
    func getSimilarMovie()->ISimilarMovies{
        return SimilarMovies()
    }
    
}
