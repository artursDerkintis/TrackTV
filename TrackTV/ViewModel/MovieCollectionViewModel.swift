//
//  MovieCollectionViewModel.swift
//  TrackTV
//
//  Created by Arturs Derkintis on 01/05/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import AlamofireSwiftyJSON
import RealmSwift

protocol MovieCollectionDelegate {
    func reloadData()
}

class MovieCollectionViewModel {
    
    public var movieViewModels : [MovieViewModel] = []
    public var delegate : MovieCollectionDelegate?
    
    private var movieArray : Results<Movie>?
    private var notificationToken : NotificationToken?
    
    
    init() {
        fetchTrendingMovies()
        addRealmNotifcationListener()
    }
    
    private func addRealmNotifcationListener(){
        self.movieArray = Movie.unfilteredResults
        self.notificationToken = movieArray?.addNotificationBlock({ (_) in
            self.movieViewModels.removeAll()
            self.movieArray?.forEach({ (movie) in
                self.movieViewModels.append(MovieViewModel(movie: movie))
            })
            self.delegate?.reloadData()
        })
    }
    
    let traktTVApiKey = "0e7e55d561c7e688868a5ea7d2c82b17e59fde95fbc2437e809b1449850d4162"
    
    /// Using Almofire fetch the trending movies from API
    private func fetchTrendingMovies(){
        let urlString = "https://api.trakt.tv/movies/trending?page=1&limit=40&extended=full"
        let headers   = ["trakt-api-version":"2","trakt-api-key":self.traktTVApiKey]
        if let url = URL(string: urlString){
            Alamofire.request(url, method: HTTPMethod.get, parameters: nil, encoding: URLEncoding.default, headers: headers).responseSwiftyJSON(completionHandler: { response in
                if let jsonObject = response.value{
                    self.saveTrendingMovies(jsonObject: jsonObject)
                }
            })
        }
    }
    
    /// Parse and store in Realm db received response
    private func saveTrendingMovies(jsonObject : JSON){
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
    
}
