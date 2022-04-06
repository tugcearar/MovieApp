//
//  MovieCell.swift
//  MovieApp
//
//  Created by Tuğçe Arar on 2.04.2022.
//

import UIKit

class MovieCell: UITableViewCell {
    @IBOutlet weak var moviePoster: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    
    class var identifier: String { return String(describing: self) }
    class var nib: UINib { return UINib(nibName: identifier, bundle: nil) }
    
    var cellViewModel: MovieCellViewModel? {
        didSet {
            movieTitle.text = cellViewModel?.name
            moviePoster.image = cellViewModel?.posterImg
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        initView()
    }

    func initView() {
        backgroundColor = .clear

        movieTitle.lineBreakMode = .byWordWrapping
        
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        movieTitle.text = nil
        moviePoster.image = nil
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
