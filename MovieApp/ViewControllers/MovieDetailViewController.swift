//
//  MovieDetailViewController.swift
//  MovieApp
//
//  Created by Tuğçe Arar on 4.04.2022.
//

import UIKit
import FirebaseAnalytics

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var year: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var actors: UILabel!
    
    var viewModel: MovieDetailViewModel?
    
    fileprivate func fillUI() {
        guard let viewModel = viewModel else {
            return
        }
        
        movieTitle.text = viewModel.movieDetail?.title
        
        var temp:String = viewModel.movieDetail?.poster ?? "https://icon-library.com/images/photo-placeholder-icon/photo-placeholder-icon-14.jpg"
        if(viewModel.movieDetail?.poster == "N/A"){
            temp = "https://icon-library.com/images/photo-placeholder-icon/photo-placeholder-icon-14.jpg"
        }
        
        let url = URL(string: temp)
        let data = try? Data(contentsOf: url!)
        let posterImg = UIImage(data: data!)
        
        poster.image = posterImg
        year.text = viewModel.movieDetail?.year
        director.text = viewModel.movieDetail?.director
        actors.text = viewModel.movieDetail?.actors
        
        Analytics.logEvent("move_detail_viewed", parameters: [
          "imdbId": viewModel.movieDetail?.imdbID,
          "name": viewModel.movieDetail?.title,
          "year": viewModel.movieDetail?.year,
          "country": viewModel.movieDetail?.country,
        ])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillUI()
        
    }
}
