//
//  MovieCollectionViewController.swift
//  TrackTV
//
//  Created by Arturs Derkintis on 23/04/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import UIKit
import RealmSwift

private let reuseIdentifier = "Cell"

class MovieCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private var movieArray : Results<Movie>?
    private var notificationToken : NotificationToken?
    
    override func loadView() {
        super.loadView()
        addRealmNotifcationListener()
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func addRealmNotifcationListener(){
        movieArray = Movie.unfilteredResults
        notificationToken = movieArray?.addNotificationBlock({ [weak self] (_) in
            self?.collectionView?.reloadData()
        })
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let currentlySelectedIndexPath = self.collectionView?.indexPathsForSelectedItems?.first, let movie = movieArray?[currentlySelectedIndexPath.row], let destinationVC = segue.destination as? MovieViewController{
            destinationVC.tmdbID = movie.tmdbID
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieArray?.count ?? 0
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.movieViewModel = nil
        if let movie = movieArray?[indexPath.row]{
            cell.movieViewModel = MovieViewModel(movie: movie)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.5, height: view.frame.height * 0.44)
    }
    
}
