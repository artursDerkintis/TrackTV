//
//  Movie.swift
//  TraktTV
//
//  Created by Arturs Derkintis on 23/04/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import UIKit
import RealmSwift


/// Movie model
class Movie: Object {
    
    /// Count of watchers
    dynamic var watchers : Int = 0
    /// Release year
    dynamic var year : Int = 0
    /// IMDB id
    dynamic var imdbID : String = ""
    
    /// Title of this movies
    dynamic var title : String = ""
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
    
    
    /// Poster of this movie
    var poster : Images?
    
    override class func primaryKey() -> String{
        return "imdbID"
    }
}
