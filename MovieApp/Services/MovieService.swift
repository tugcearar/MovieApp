//
//  MovieService.swift
//  MovieApp
//
//  Created by Tuğçe Arar on 3.04.2022.
//

import Foundation


protocol MovieServiceProtocol{
    func getMovies(completion: @escaping (_ results: Welcome?) -> ())
    func searchMovies(searchText: String, completion: @escaping (_ results: Welcome?) -> ())
    func getMovieDetail(imdbId: String,completion: @escaping (_ results:MovieDetail?) -> ())
}

class MovieService: MovieServiceProtocol {
    
    func searchMovies(searchText: String,completion: @escaping (Welcome?) -> ()) {
        let url = "https://www.omdbapi.com/?apikey=29ce7b82&s="+searchText+"&type=movie&page=1"
        request(url: url, completion: completion)
    }
    
    func getMovies(completion: @escaping  (Welcome?) -> ()) {
        let url =  "https://www.omdbapi.com/?apikey=29ce7b82&s=batman&type=movie&page=1"
        request(url: url, completion: completion)
    }
    
    func getMovieDetail(imdbId: String,completion: @escaping (MovieDetail?) -> ()) {
        let url = "https://www.omdbapi.com/?apikey=29ce7b82&i="+imdbId+"&type=movie&page=1"
        request(url: url, completion: completion)
    }
    
    func request<T: Decodable>(url:String, completion: @escaping (T?) -> ()) {
        
        let requestUrl = URL(string: url)
        var request = URLRequest(url: requestUrl!)
        request.httpMethod = "GET"
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                
                print("Error took place \(error)")
                
                return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            let dataString:String = String(data: data!, encoding: String.Encoding.utf8)!
            print(dataString)
            let decoder = JSONDecoder()
            do {
                let movies = try decoder.decode(T.self, from: data!)
                print(movies)
                completion(movies)
            } catch {
                print(error.localizedDescription)
            }
        }
        dataTask.resume()
    }
}
