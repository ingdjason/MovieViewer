//
//  DetailsViewController.swift
//  MovieViewer
//
//  Created by Djason  Sylvaince on 9/24/18.
//  Copyright © 2018 Djason  Sylvaince. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    
    @IBOutlet weak var backdropImageView: UIButton!
    
    @IBOutlet weak var ratingLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var movie: NSDictionary!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set scroll after added the UISCROLLVIEW
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        
        let title = movie["title"] as! String
        titleLabel.text = title
        
        let release_date = movie["release_date"] as! String
        dateLabel.text = release_date
        
        let vote_average = movie["vote_average"] as! NSNumber
        ratingLabel.text = "\(vote_average)/10"
        
        let overview = movie["overview"] as! String
        overviewLabel.text = overview
        //and set autogrow for text label to fit with the text
        overviewLabel.sizeToFit()
        
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        if let poster_path = movie["poster_path"] as? String {
            let imageUrl = NSURL(string: baseUrl+poster_path )
            backdropImageView.setImageFor(UIControlState.normal, with: imageUrl! as URL)
            
            //(imageUrl! as URL)
        }
        
        if let backdrop_path = movie["backdrop_path"] as? String {
            let imageUrlBack = NSURL(string: baseUrl+backdrop_path )
            posterImageView.setImageWith(imageUrlBack! as URL)
        }
        
        
        //print(movie)
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func onDetails(_ sender: Any) {
        performSegue(withIdentifier: "detailsVC", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destVC : WebViewController = segue.destination as! WebViewController
        destVC.movie = movie
        
        /*if (segue.identifier == "detailsVC") {
            // Get the new view controller using segue.destinationViewController.
            let webViewDestination = segue.destination as! WebViewController
            // Pass the selected object to the new view controller.
            webViewDestination.movie = movie
        }else{
            print("segue not ok")
        }*/
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
