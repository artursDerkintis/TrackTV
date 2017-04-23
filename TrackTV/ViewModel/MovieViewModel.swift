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
    
    var thumbnailURL : URL?{
        return URL(string: movie?.images?.mostLikedMovieThumbUrl ?? "")
    }
    
    var posterURL : URL?{
        return URL(string: movie?.images?.mostLikedMoviePosterUrl ?? "")
    }
    
    var ratingString : String{
        return String(format: "⭐️ %.1f", movie?.rating ?? 0.0)
    }
    
    var title : String {
        return movie?.title ?? ""
    }
    
    var summary : String {
        return movie?.overview ?? ""
    }
    
    var genres : [String] {
        var genres : [String] = []
        movie?.genres.forEach { genres.append($0.genre.capitalized) }
        return genres
    }
    
    var tagline : String {
        return movie?.tagline ?? ""
    }
    
    convenience init(movie : Movie) {
        self.init()
        
    }
}
