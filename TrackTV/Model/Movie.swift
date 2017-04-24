//
//  Movie.swift
//  TraktTV
//
//  Created by Arturs Derkintis on 23/04/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON


/// Movie model
class Movie: Object {
    
    /// Count of watchers
    dynamic var watchers : Int = 0
    /// Release year
    dynamic var year : Int = 0
    /// IMDB id
    dynamic var imdbID : String = ""
    
    /// The movie data base id
    dynamic var tmdbID : Int = 0
    
    /// Title of this movies
    dynamic var title : String = ""
    /// Tagline for this movie
    dynamic var tagline : String = ""
    /// Website for this movie
    dynamic var homepage : String = ""
    /// Summary / Description
    dynamic var overview : String = ""
    /// Rating
    dynamic var rating : Double = 0.0
    /// Total votes count
    dynamic var votes : Int = 0
    /// Link for trailer for this movie
    dynamic var trailer : String = ""
    
    /// Array of genres this movies belongs to
    var genres : List<Genre> = List<Genre>()
    
    
    /// Poster URL String
    dynamic var filePathForPoster : String = ""
    
    
    override class func primaryKey() -> String{
        return "imdbID"
    }
}


extension Movie{
    
    static func parse(jsonObject : JSON) -> Movie?{
        let movieObject     = jsonObject[JSONKeys.movie]
        guard let watchers  = jsonObject[JSONKeys.watchers].int,
            let year    = movieObject[JSONKeys.year].int,
            let imdb    = movieObject[JSONKeys.ids][JSONKeys.imdb].string,
            let tmdb    = movieObject[JSONKeys.ids][JSONKeys.tmdb].int,
            let title   = movieObject[JSONKeys.title].string,
            let tagline = movieObject[JSONKeys.tagline].string,
            let votes   = movieObject[JSONKeys.votes].int,
            let overview    = movieObject[JSONKeys.overview].string,
            let rating      = movieObject[JSONKeys.rating].double,
            let trailer     = movieObject[JSONKeys.trailer].string,
            let homepage    = movieObject[JSONKeys.homepage].string,
            let genreArray  = movieObject[JSONKeys.genres].array
            else{
                return nil
        }
        var genres : [Genre] = []
        genreArray.forEach { genres.append(Genre(string: $0.string)) }
        let movie = Movie()
        movie.tagline = tagline
        movie.genres = List(genres)
        movie.homepage = homepage
        movie.trailer = trailer
        movie.imdbID = imdb
        movie.tmdbID = tmdb
        movie.title = title
        movie.watchers = watchers
        movie.votes = votes
        movie.year = year
        movie.overview = overview
        movie.rating = rating
        return movie
    }
    
    func getImages(){
        DataHandler.fetchImagesForMovie(tmdbID: tmdbID)
    }
    
    public static var unfilteredResults : Results<Movie>? {
        return RealmHelper.realm?.objects(Movie.self)
    }
    
    public static func movie(tmdbID : Int) -> Movie? {
        return RealmHelper.realm?.objects(Movie.self).filter("tmdbID == \(tmdbID)").first
    }
}
