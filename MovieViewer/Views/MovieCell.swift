//
//  MovieCell.swift
//  MovieViewer
//
//  Created by Djason  Sylvaince on 9/16/18.
//  Copyright © 2018 Djason  Sylvaince. All rights reserved.
//

import UIKit
//import Alamofire
import AlamofireImage

class MovieCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var posterView: UIImageView!
    
    var movies: Movie!{
        didSet {
            titleLabel.text = movies.title
            overviewLabel.text = movies.overview
            
            let baseUrl = "https://image.tmdb.org/t/p/w500"
            let placeholderImage = UIImage(named: "placeholder")!
            let poster_path = URL(string: baseUrl + movies.posterUrl!)
            posterView.af_setImage(withURL: poster_path!, placeholderImage: placeholderImage)
        }
    }
     
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
