//
//  ViewController.swift
//  Teste DCX
//
//  Created by Eduardo Sumiya on 07/03/18.
//  Copyright © 2018 Eduardo Sumiya. All rights reserved.
//

import UIKit
import PKHUD

protocol MoviesListInterface : NSObjectProtocol {
    func LoadMovies(movies : Array<MovieModel>)
    func OnError(error : Error)
}

class MoviesListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, MoviesListInterface {
    
    private var movies : Array<MovieModel>?
    
    @IBOutlet weak var collectionMovies: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let moviesListPresenter = MoviesListPresenter()
        
        moviesListPresenter.attachView(view: self)
        moviesListPresenter.GetMovies(pageNumber: 1)
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show(onView: self.view)
    }
    
    func LoadMovies(movies: Array<MovieModel>) {
        PKHUD.sharedHUD.hide()
        self.movies = movies
        collectionMovies.dataSource = self
        collectionMovies.delegate = self
        collectionMovies.reloadData()
    }
    
    func OnError(error: Error) {
        PKHUD.sharedHUD.hide(true) { (hide) in
            PKHUD.sharedHUD.contentView = PKHUDTextView(text: error.localizedDescription)
            PKHUD.sharedHUD.show(onView: self.view)
            PKHUD.sharedHUD.hide(afterDelay: 3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : UICollectionViewCell = UICollectionViewCell()
        
        return cell
    }
    
    
}

