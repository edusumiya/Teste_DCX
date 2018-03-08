//
//  MoviesListPresenter.swift
//  Teste DCX
//
//  Created by Eduardo Sumiya on 08/03/18.
//  Copyright © 2018 Eduardo Sumiya. All rights reserved.
//

import Foundation

class MoviesListPresenter: NSObject {
    
    weak private var viewMovies : MoviesListInterface?
    
    override init() {
    }
    
    func attachView(view:MoviesListInterface){
        self.viewMovies = view
    }
    
    func GetMovies(pageNumber : Int) {
        DiscoverMoviesAPI.sharedInstance.GetMovies(numberOfPage: 1, onCompletion: { (movies) in
            self.viewMovies?.LoadMovies(movies: movies.results!)
        }) { (error) in
            self.viewMovies?.OnError(error: error)
        }
    }
}
