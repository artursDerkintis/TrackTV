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
    
    /// Returns valid url for thumnail - if available
    var thumbnailURL : URL?{
        return URL(string: movie?.images?.mostLikedMovieThumbUrl ?? "")
    }
    
    /// Returns valid url for poster - if available
    var posterURL : URL?{
        return URL(string: movie?.images?.mostLikedMoviePosterUrl ?? "")
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
    var genres : [String] {
        var genres : [String] = []
        movie?.genres.forEach { genres.append($0.genre.capitalized) }
        return genres
    }
    
    /// This viewmodel should have movie model object to initialise
    convenience init(movie : Movie) {
        self.init()
        
    }
}
