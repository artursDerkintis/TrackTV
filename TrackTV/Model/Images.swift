//
//  Images.swift
//  TraktTV
//
//  Created by Arturs Derkintis on 23/04/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftyJSON

/// Poster of movie model
class Images : Object {
    dynamic var mostLikedMoviePosterUrl : String = ""
    dynamic var mostLikedMovieThumbUrl : String = ""
    /// Could have many other urls here
    
    override class func primaryKey() -> String{
        return "mostLikedMovieThumbUrl"
    }
}

extension Images{
    public static func parse(jsonObject : JSON) -> Images?{
        guard let movieThumb = jsonObject[JSONKeys.moviethumb].array,
            let moviePoster = jsonObject[JSONKeys.movieposter].array else{
                return nil
        }
        guard let movieThumbUrl = movieThumb[0][JSONKeys.url].string,
            let moviePosterUrl = moviePoster[0][JSONKeys.url].string else{
                return nil
        }
        let images = Images()
        images.mostLikedMoviePosterUrl = moviePosterUrl
        images.mostLikedMovieThumbUrl = movieThumbUrl
        return images
    }
}
