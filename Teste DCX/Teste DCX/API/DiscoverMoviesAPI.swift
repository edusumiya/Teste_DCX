//
//  AuthenticationRepository.swift
//  Teste DCX
//
//  Created by Eduardo Sumiya on 07/03/18.
//  Copyright © 2018 Eduardo Sumiya. All rights reserved.
//

import Foundation
import SwiftyJSON
import JSONParserSwift

typealias ServiceResponse = (JSON, NSError?) -> Void

class DiscoverMoviesAPI {
    
    static let sharedInstance = DiscoverMoviesAPI()
    
    func GetMovies(numberOfPage : Int, onCompletion:@escaping (MoviesBaseModel) -> Void, onError: @escaping (Error) -> Void)  {
        let urlRequest = URL(string: Constants.baseURL + "discover/movie" + Constants.apiKey + "&page=" + String(numberOfPage))!
        
        let request = NSMutableURLRequest(url: urlRequest, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 10.0)
        request.httpMethod = "GET"
        
        let session = URLSession.shared
        let dataTask = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if (error != nil) {
                onError(error!)
            } else {
                do {
                    let baseResponse : MoviesBaseModel = try JSONParserSwift.parse(data: data!)
                    
                    DispatchQueue.main.async {
                        onCompletion(baseResponse)
                    }
                } catch {
                    DispatchQueue.main.async {
                        onError(error)
                    }
                }
            }
        }
        dataTask.resume()
    }
}
