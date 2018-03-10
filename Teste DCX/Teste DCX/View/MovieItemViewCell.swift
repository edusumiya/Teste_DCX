//
//  MovieItemViewCell.swift
//  Teste DCX
//
//  Created by Eduardo Sumiya on 09/03/2018.
//  Copyright © 2018 Eduardo Sumiya. All rights reserved.
//

import Foundation
import UIKit

class MovieItemViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imgMovieBanner: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    
    override func awakeFromNib() {
        super .awakeFromNib()
    }
    
    func setData(movieTitle : String, movieDescription : String, imageURL : String) {
        lblTitle.text = movieTitle
        lblDescription.text = movieDescription
        
        let url = URL(string: String(Constants.baseImageURL + "300" + imageURL))
        ImageServiceAPI.sharedInstance.DownloadImage(url: url!, completion: { (image) in
            self.imgMovieBanner.image = image
        }) { (error) in
            self.imgMovieBanner.image = nil
        }
    }
}
