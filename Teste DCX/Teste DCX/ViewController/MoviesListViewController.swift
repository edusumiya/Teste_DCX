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
    func LoadMovies(movies : MoviesBaseModel)
    func OnError(error : Error)
}

class MoviesListViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, MoviesListInterface {
    
    private var movies : MoviesBaseModel?
    private let cellIdentifier : String = "MovieListCell"
    private var moviesListPresenter : MoviesListPresenter!
    private var moviesCount : Int!
    
    @IBOutlet weak var collectionMovies: UICollectionView!
    @IBOutlet weak var lblPagina: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "FILMES";
        moviesCount = 0
        
        moviesListPresenter = MoviesListPresenter()
        moviesListPresenter.attachView(view: self)
        
        collectionMovies.register(UINib(nibName: "MovieItemViewCell", bundle: nil), forCellWithReuseIdentifier: cellIdentifier)
        collectionMovies.dataSource = self
        collectionMovies.delegate = self
        
        GetMovies(pageNumber: 1)
    }
    
    @IBAction func VoltarLista(_ sender: Any) {
        let page = movies?.page as! Int - 1
        if page >= 1 {
            GetMovies(pageNumber: page)
        }
    }
    @IBAction func AvancarLista(_ sender: Any) {
        let page = movies?.page as! Int + 1
        if page <= (movies?.total_pages as! Int) {
            GetMovies(pageNumber: page)
        }
    }
    
    func GetMovies(pageNumber : Int) {
        moviesListPresenter.GetMovies(pageNumber: pageNumber)
        
        PKHUD.sharedHUD.contentView = PKHUDProgressView()
        PKHUD.sharedHUD.show(onView: self.view)
    }
    
    func LoadMovies(movies: MoviesBaseModel) {
        PKHUD.sharedHUD.hide()
        self.movies = movies
        lblPagina.text = String(self.movies!.page as! Int)
        
        moviesCount = (movies.results!.count)
        
        if collectionMovies.numberOfItems(inSection: 0) != 0 {
            collectionMovies.scrollToItem(at: IndexPath(row: 0, section: 0),at: .top,animated: false)
        }
        
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
        return moviesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : MovieItemViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! MovieItemViewCell
        let movie : MovieModel = movies!.results![indexPath.row]
        
        cell.setData(movieTitle: movie.title!, movieDescription: movie.overview!, imageURL: movie.poster_path!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movieDetail : MovieDetailViewController = storyboard?.instantiateViewController(withIdentifier: "MovieDetail") as! MovieDetailViewController
        
        movieDetail.SetUpDetail(movie: movies!.results![indexPath.row])
        
        self.navigationController?.pushViewController(movieDetail, animated: true)

    }
}
