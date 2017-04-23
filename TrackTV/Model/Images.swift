//
//  Images.swift
//  TraktTV
//
//  Created by Arturs Derkintis on 23/04/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import UIKit
import RealmSwift


/// Poster of movie model
class Images : Object {
    dynamic var mostLikedMoviePosterUrl : String = ""
    dynamic var mostLikedMovieThumbUrl : String = ""
    /// Could have many other urls here
    
    override class func primaryKey() -> String{
        return "mostLikedMovieThumbUrl"
    }
}
