//
//  MoviesBaseModel.swift
//  Teste DCX
//
//  Created by Eduardo Sumiya on 08/03/18.
//  Copyright © 2018 Eduardo Sumiya. All rights reserved.
//

import Foundation
import JSONParserSwift

class MoviesBaseModel : ParsableModel {
    var page : NSNumber?
    var total_results : NSNumber?
    var total_pages : NSNumber?
    var results : Array<MovieModel>?
}
