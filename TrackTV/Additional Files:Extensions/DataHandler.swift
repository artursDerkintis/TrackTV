//
//  DataHandler.swift
//  TraktTV
//
//  Created by Arturs Derkintis on 22/04/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireSwiftyJSON


/// This is where data fetching/saving/retrieving happens
struct DataHandler {
    
    static let tmdbApiKey = "f4e1e1800da1176bb15bc0b4c3b3a575"
    static let traktTVApiKey = "0e7e55d561c7e688868a5ea7d2c82b17e59fde95fbc2437e809b1449850d4162"
    
    /// Using Almofire fetch the trending movies from API
    public static func fetchTrendingMovies(){
        let urlString = "https://api.trakt.tv/movies/trending?page=1&limit=40&extended=full"
        let headers   = ["trakt-api-version":"2","trakt-api-key":DataHandler.traktTVApiKey]
        if let url = URL(string: urlString){
            Alamofire.request(url, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseSwiftyJSON(completionHandler: { response in
                if let jsonObject = response.value{
                    DataHandler.saveTrendingMovies(jsonObject: jsonObject)
                }
            })
        }
    }
    
    /// Parse and store in Realm db received response
    fileprivate static func saveTrendingMovies(jsonObject : JSON){
        // To prevent UI from freezing, move all parsing/storing of data to seperate thread
        RealmHelper.realmThread.async {
            if let arrayOfMovieObjects = jsonObject.array{
                var movies : [Movie] = []
                arrayOfMovieObjects.forEach {
                    if let movie = Movie.parse(jsonObject: $0){
                        movies.append(movie)
                        movie.getImages()
                    }
                }
                RealmHelper.safeWrite {
                    movies.forEach { RealmHelper.realm?.add($0, update: true) }
                }
            }
        }
    }
    
    /// Seperatly fetch image urls, since trackTV API don't have thier own endpoint for it I had to use Fanart API
    public static func fetchImagesForMovie(tmdbID : Int){
        
        let urlString = "https://api.themoviedb.org/3/movie/\(tmdbID)/images?api_key=\(DataHandler.tmdbApiKey)"
        if let url = URL(string: urlString){
            Alamofire.request(url).responseSwiftyJSON(completionHandler: { response in
                RealmHelper.realmThread.async {
                    if let jsonObject = response.value{
                        if let posters = jsonObject[JSONKeys.posters].array{
                            if let filePath = posters[0][JSONKeys.filePath].string{
                                let movie = Movie.movie(tmdbID: tmdbID)
                                RealmHelper.safeWrite {
                                    movie?.filePathForPoster = filePath
                                }
                            }
                        }
                    }
                }
            })
        }
        
    }
    
    
}
