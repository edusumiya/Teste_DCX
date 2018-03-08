//
//  MovieModel.swift
//  Teste DCX
//
//  Created by Eduardo Sumiya on 08/03/18.
//  Copyright © 2018 Eduardo Sumiya. All rights reserved.
//

import Foundation
import JSONParserSwift

class MovieModel : ParsableModel {
    var vote_count : String?
    var id : NSNumber?
    var video : NSNumber?
    var vote_average : String?
    var title : String?
    var popularity : String?
    var poster_path : String?
    var original_language : String?
    var original_title : String?
    var genre_ids : Array<NSNumber>?
    var backdrop_path : String?
    var adult : NSNumber?
    var overview : String?
    var release_date : String?
}
