//
//  ViewController.swift
//  MovieApp
//
//  Created by Tuğçe Arar on 2.04.2022.
//

import UIKit
import Firebase
import AVFoundation

class ViewController: UIViewController, UISearchBarDelegate {
    @IBOutlet private var searchBar: UISearchBar!
    @IBOutlet var movieTableView: UITableView!
    @IBOutlet weak var loadingInd: UIActivityIndicatorView!
    @IBOutlet weak var loadingView: UIView! {
        didSet {
            loadingView.layer.cornerRadius = 6
        }
    }
    
    lazy var viewModel = {
        MoviesViewModel()
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        initViewModel()
    }
    
    func initView() {
        movieTableView.delegate = self
        movieTableView.dataSource = self
        movieTableView.separatorColor = .black
        movieTableView.separatorStyle = .singleLine
        movieTableView.tableFooterView = UIView()
        
        movieTableView.register(MovieCell.nib, forCellReuseIdentifier: MovieCell.identifier)
        
        searchBar.delegate? = self
        
        loadingInd.color = .red
        
        loadingView.layer.opacity = 0.5
    }
    
    func initViewModel(searchText: String? = nil) {
        self.isLoading(show: true)
        if let searchText = searchText {
            viewModel.searchMovies(searchText: searchText)
        }else{
            viewModel.getMovies()
        }
        
      
        self.viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
            self?.movieTableView.reloadData()
            }
           
        }
        self.isLoading(show: false)
    }
    func isLoading(show:Bool){
        if(show){
            loadingInd.startAnimating()
            loadingView.isHidden = false
        }
        else{
            DispatchQueue.main.async {
                self.loadingInd.stopAnimating()
                self.loadingView.isHidden = true
            }
            
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        initViewModel(searchText: searchBar.text)
    }
}

extension ViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movieCellViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCell.identifier, for: indexPath) as? MovieCell else {
            fatalError("Issue with dequeuing")
        }
        let cellVM = viewModel.getCellViewModel(at: indexPath)
        cell.cellViewModel = cellVM
        return cell
    }
}

extension ViewController : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.isLoading(show: true)
        tableView.deselectRow(at: indexPath, animated: false)
        DispatchQueue.main.async {
            let storyboard = UIStoryboard(name: "Main", bundle:nil)
            if let viewController = storyboard.instantiateViewController(identifier: "MovieDetailViewController") as? MovieDetailViewController {
                viewController.viewModel = MovieDetailViewModel(id: self.viewModel.getCellViewModel(at: indexPath).id)
                self.isLoading(show: false)
                self.present(viewController, animated: true)
            }
        }
        
    }
}
