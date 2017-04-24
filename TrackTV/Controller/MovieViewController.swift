//
//  MovieViewController.swift
//  TrackTV
//
//  Created by Arturs Derkintis on 24/04/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import UIKit
import SafariServices

class MovieViewController: UIViewController {
    
    private var movieViewModel : MovieViewModel?
    
    var tmdbID : Int? {
        didSet{
            if let tmdbID = tmdbID, let movie = Movie.movie(tmdbID: tmdbID){
                movieViewModel = MovieViewModel(movie: movie)
            }
        }
    }
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Once view is live set all the values
        if let movieViewModel = movieViewModel{
            if let posterURL = movieViewModel.posterURL{
                posterImageView.af_setImage(withURL: posterURL)
            }
            titleLabel.text = movieViewModel.title
            taglineLabel.text = movieViewModel.tagline
            yearLabel.text = movieViewModel.year
            genreLabel.text = movieViewModel.genres
            summaryLabel.text = movieViewModel.summary
            ratingLabel.text = movieViewModel.ratingString
        }
    }
    
    /// Open website of the movie
    @IBAction func openHomepage(_ sender: Any) {
        if let url = movieViewModel?.homepageURL{
            openURL(url: url)
        }
    }
    
    
    /// Open trailer of this movie
    @IBAction func openTrailer(_ sender: Any) {
        if let url = movieViewModel?.trailerURL{
            openURL(url: url)
        }
    }
    
    /// Opens the url _official_ way 
    func openURL(url : URL){
        let safariVC = SFSafariViewController(url: url)
        present(safariVC, animated: true, completion: nil)
    }
    
}
