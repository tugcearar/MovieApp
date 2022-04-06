//
//  MovieDetailViewModel.swift
//  MovieApp
//
//  Created by Tuğçe Arar on 4.04.2022.
//

import Foundation
import UIKit

class MovieDetailViewModel{
    
    private var movieService: MovieServiceProtocol
    
    var movieDetail: MovieDetail?
    
    init(id: String,  movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService
        
        getMovieDetail(imdbId:id)
    }
    
    func getMovieDetail(imdbId: String) {
        movieService.getMovieDetail(imdbId: imdbId) { model in
            if let movieDetail = model {
                self.movieDetail = movieDetail
                
            } else {
                print("error")
            }
        }
    }
}
