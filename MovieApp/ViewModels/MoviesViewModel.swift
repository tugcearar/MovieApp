//
//  MoviesViewModel.swift
//  MovieApp
//
//  Created by Tuğçe Arar on 3.04.2022.
//

import Foundation
import UIKit

class MoviesViewModel {
    private var movieService: MovieServiceProtocol
    var movieDetail: MovieDetail?
    var reloadTableView: (() -> Void)?
    
    var movies = Welcome(search: [Search](), totalResults: "", response: "")
    
    var movieCellViewModel = [MovieCellViewModel]() {
        didSet {
            reloadTableView?()
        }
    }
    
    init(movieService: MovieServiceProtocol = MovieService()) {
        self.movieService = movieService
    }
    
    func getMovies() {
        movieService.getMovies() { model in
            if let movies = model {
                self.fetchData(movies: movies)
            } else {
                print("error")
            }
        }
    }
    
    
    func searchMovies(searchText: String) {
        movieService.searchMovies(searchText: searchText) { model in
            if let movies = model {
                self.fetchData(movies: movies)
            } else {
                print("error")
            }
        }
    }
    
    func fetchData(movies: Welcome) {
        self.movies = movies
        var vms = [MovieCellViewModel]()
        for movie in movies.search {
            vms.append(createCellModel(movie: movie))
        }
        movieCellViewModel = vms
    }
    
    func createCellModel(movie: Search) -> MovieCellViewModel {
        let id = movie.imdbID
        let name = movie.title
        var poster = movie.poster
        
        if(poster == "N/A"){
            poster = "https://icon-library.com/images/photo-placeholder-icon/photo-placeholder-icon-14.jpg"
        }
        
        let url = URL(string: poster)
        let data = try? Data(contentsOf: url!)
        let posterImg = UIImage(data: data!)
        return MovieCellViewModel(id: id, name: name, poster: poster, posterImg: posterImg!)
    }
    
    func getCellViewModel(at indexPath: IndexPath) -> MovieCellViewModel {
        return movieCellViewModel[indexPath.row]
    }
    
    
}
