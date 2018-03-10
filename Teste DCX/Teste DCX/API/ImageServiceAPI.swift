//
//  ImageServiceAPI.swift
//  Teste DCX
//
//  Created by Eduardo Sumiya on 09/03/2018.
//  Copyright © 2018 Eduardo Sumiya. All rights reserved.
//

import Foundation
import UIKit

class ImageServiceAPI {
    static let sharedInstance = ImageServiceAPI()
    
    func DownloadImage(url: URL, completion: @escaping (UIImage) -> Void, onError: @escaping (Error) -> Void) {
        GetImageFromUrl(url: url) { (data, response, error) in
            if (error != nil)
            {
                onError(error!)
            }
            
            completion(UIImage(data: data!)!)
        }
    }

    private func GetImageFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async() {
                completion(data, response, error)
            }
        }.resume()
    }
}
