//
//  MovieDetailViewController.swift
//  Teste DCX
//
//  Created by Eduardo Sumiya on 10/03/2018.
//  Copyright © 2018 Eduardo Sumiya. All rights reserved.
//

import Foundation
import UIKit
import Cosmos

protocol MovieDetailInterface : NSObjectProtocol{
    func SetUpDetail(movie : MovieModel)
}

class MovieDetailViewController : UIViewController, MovieDetailInterface {
    
    var movie : MovieModel!
    
    @IBOutlet weak var imgMovie: UIImageView!
    @IBOutlet weak var lblMovieName: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var viewRating: CosmosView!
    @IBOutlet weak var lblDescription: UITextView!
    
    override func viewDidLoad() {
        super .viewDidLoad()
        
        let url = URL(string: String(Constants.baseImageURL + "300" + movie.poster_path!))
        ImageServiceAPI.sharedInstance.DownloadImage(url: url!, completion: { (image) in
            self.imgMovie.image = image
        }) { (error) in
            self.imgMovie.image = nil
        }
        
        self.navigationItem.title = "INFOS"
        
        lblMovieName.text = movie.title!
        
        let movieDate: String = movie.release_date!
        let year: String = (movieDate as NSString).substring(to: 4)
        lblDate.text = year
        
        viewRating.rating = Double(truncating: movie.vote_average!) / 2
        
        lblDescription.text = movie.overview
    }

    func SetUpDetail(movie: MovieModel) {
        self.movie = movie
    }
}
