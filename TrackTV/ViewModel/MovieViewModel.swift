//
//  MovieViewModel.swift
//  TrackTV
//
//  Created by Arturs Derkintis on 24/04/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import UIKit

class MovieViewModel {
    
    private var movie : Movie?

    /// Returns valid url for poster - if available
    var posterURL : URL?{
        return URL(string: "https://image.tmdb.org/t/p/w500\(movie?.filePathForPoster ?? "")")
    }
    
    /// Returns rating rounded up
    var ratingString : String{
        return String(format: "⭐️ %.1f", movie?.rating ?? 0.0)
    }
    
    /// Returns title of the movie
    var title : String {
        return movie?.title ?? ""
    }
    
    /// Returns tagline of the movie
    var tagline : String {
        return movie?.tagline ?? ""
    }
    
    /// Returns summary of the movie
    var summary : String {
        return movie?.overview ?? ""
    }
    
    /// Returns list of genres this movie belongs to
    var genres : String {
        var genres : String = ""
        movie?.genres.forEach { genres.append("\($0.genre.capitalized)  ") }
        return genres
    }
    
    var year : String {
        return "\(movie?.year ?? 1970)"
    }
    
    var homepageURL : URL? {
        return URL(string: movie?.homepage ?? "")
    }
    
    var trailerURL : URL? {
        return URL(string: movie?.trailer ?? "")
    }
    
    /// This viewmodel should have movie model object to initialise
    convenience init(movie : Movie) {
        self.init()
        self.movie = movie
    }
}
