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

    let viewModel = MovieCollectionViewModel()
    
    override func loadView() {
        super.loadView()
        viewModel.delegate = self
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        /// Sets tmdbID for destination MovieViewController so when it's live it could show more details of selected movie
        if let currentlySelectedIndexPath = self.collectionView?.indexPathsForSelectedItems?.first, let destinationVC = segue.destination as? MovieViewController{
            let movieViewModel = viewModel.movieViewModels[currentlySelectedIndexPath.row]
            destinationVC.tmdbID = movieViewModel.tmdbID
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.movieViewModels.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? MovieCollectionViewCell else{
            return UICollectionViewCell()
        }
        cell.movieViewModel = viewModel.movieViewModels[indexPath.row]
        return cell
    }
    
    /// Simple design calculations
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width * 0.5, height: view.frame.height * 0.44)
    }
    
}

extension MovieCollectionViewController : MovieCollectionDelegate{
    
    func reloadData() {
        self.collectionView?.reloadData()
    }
}
