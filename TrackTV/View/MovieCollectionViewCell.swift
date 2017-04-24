//
//  MovieCollectionViewCell.swift
//  TrackTV
//
//  Created by Arturs Derkintis on 23/04/2017.
//  Copyright © 2017 Arturs Derkintis. All rights reserved.
//

import UIKit
import AlamofireImage


///Custom CollectionViewCell
class MovieCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    
    var movieViewModel : MovieViewModel? {
        didSet{
            if let thumbnailURL = movieViewModel?.posterURL{
                thumbImageView.af_setImage(withURL: thumbnailURL)
            }
            if let title = movieViewModel?.title,
                let rating = movieViewModel?.ratingString{
                titleLabel.text = title
                ratingLabel.text = rating
                return
            }
            thumbImageView.image = nil
            titleLabel.text = ""
            ratingLabel.text = ""
        }
    }
    
}
