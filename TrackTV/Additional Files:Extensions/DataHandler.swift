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

typealias ImagesCompleted = (_ image : Images) -> Void

/// This is where data fetching/saving/retrieving happens
struct DataHandler {
    
    static let fanArtApiKey = "367797a09f5c04b6e06923a50bc3e822"
    static let traktTVApiKey = "0e7e55d561c7e688868a5ea7d2c82b17e59fde95fbc2437e809b1449850d4162"
    
    public static func fetchTrendingMovies(){
        let urlString = "https://api.trakt.tv/movies/trending?page=1&limit=50&extended=full"
        let headers   = ["trakt-api-version":"2","trakt-api-key":DataHandler.traktTVApiKey]
        if let url = URL(string: urlString){
            Alamofire.request(url, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseSwiftyJSON(completionHandler: { response in
                if let jsonObject = response.value{
                    DataHandler.saveTrendingMovies(jsonObject: jsonObject)
                }
            })
        }
    }
    
    fileprivate static func saveTrendingMovies(jsonObject : JSON){
        
        if let arrayOfMovieObjects = jsonObject.array{
            var movies : [Movie] = []
            arrayOfMovieObjects.forEach {
                if let movie = Movie.parse(jsonObject: $0){
                    movies.append(movie)
                    movie.getImages()
                }
            }
            RealmHelper.realmThread.async {
                RealmHelper.safeWrite {
                    movies.forEach { RealmHelper.realm?.add($0, update: true) }
                }
            }
        }
    }
    
    
    public static func fetchImagesForMovie(imdbID : String, completion : ImagesCompleted){
        
        let urlString = "https://webservice.fanart.tv/v3/movies/\(imdbID)?api_key=\(DataHandler.fanArtApiKey)"
        if let url = URL(string: urlString){
            Alamofire.request(url).responseSwiftyJSON(completionHandler: { response in
                
            })
        }
        
    }
    
    
}
