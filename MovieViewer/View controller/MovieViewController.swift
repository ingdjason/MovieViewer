//
//  MovieViewController.swift
//  MovieViewer
//
//  Created by Djason  Sylvaince on 9/16/18.
//  Copyright © 2018 Djason  Sylvaince. All rights reserved.
//

import UIKit
//import AFNetworking

class MovieViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    var movies: [Movie] = []
    var filter: [[String: Any]]?
    var refreshControl : UIRefreshControl!
    var endPoint: String!
    var url_api: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //set refresh controller
        refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(MovieViewController.didPullToRefresh(_:)), for: .valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        // Do any additional setup after loading the view.

        self.tableView.estimatedRowHeight = 210
        //self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.rowHeight = 210
        
        self.tableView.sectionHeaderHeight = 0
        self.tableView.sectionFooterHeight = 0
        
        tableView.dataSource = self
        tableView.delegate = self
        
        //searching a table
        searchBar.delegate = self
        self.navigationItem.titleView = searchBar
        
        // Start the activity indicator
       
        /*url_api = "https://api.themoviedb.org/3/movie/\(endPoint!)?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"
        */
        
        self.activityIndicator.startAnimating()//now_playing
        fetchAllMovies()
        
    }
    
    @objc func didPullToRefresh(_ refreshControl: UIRefreshControl){
        self.activityIndicator.startAnimating()
        /*url_api = "https://api.themoviedb.org/3/movie/\(endPoint!)?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed"*/
        
        fetchAllMovies()
    }
    
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    // This method updates filteredData based on the text in the Search Box
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        if(searchText.isEmpty){
            let alertController = UIAlertController(title: "Search field empty", message: "Cannot get result for empty search...", preferredStyle: .alert)
            
            // create an OK action
            let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                // handle response here.
               // self.fetchAllMovies()
            }
            // add the OK action to the alert controller
            alertController.addAction(OKAction)
            self.present(alertController, animated: true) {
                // optional code for what happens after the alert controller has finished presenting
            }
        }else{
            self.activityIndicator.startAnimating()
            //searchText
           /* url_api = "https://api.themoviedb.org/3/search/movie?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&query=\(searchText)"*/
            fetchAllMovies();
        }
        
        
    }
    
    func fetchAllMovies(){
        /**/
        MovieApiManager().nowPlayingMovies { (movies: [Movie]?, error: Error?) in
            self.activityIndicator.startAnimating()
            if let movies = movies {
                self.movies =  movies
                self.activityIndicator.stopAnimating()
                self.tableView.reloadData()
                self.refreshControl.endRefreshing()
            }else if let error = error {
                    //print("ERROR: \(error.localizedDescription)")
                    let alertController = UIAlertController(title: "Cannot get movies", message: "The internet connection appears to be offline", preferredStyle: .alert)
                    
                    // create an OK action
                    let CancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
                        // handle response here.
                        
                    }
                    // add the OK action to the alert controller
                    alertController.addAction(CancelAction)
                    
                    // create an OK action
                    let OKAction = UIAlertAction(title: "Try again", style: .default) { (action) in
                        // handle response here.
                        self.fetchAllMovies()
                    }
                    // add the OK action to the alert controller
                    alertController.addAction(OKAction)
                    self.present(alertController, animated: true) {
                        // optional code for what happens after the alert controller has finished presenting
                }
            }
        }
        /*print(endPoint)
        let url = URL(string: url_api!)!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                //print("ERROR: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Cannot get movies", message: "The internet connection appears to be offline", preferredStyle: .alert)
                
                // create an OK action
                let CancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
                    // handle response here.
                    
                }
                // add the OK action to the alert controller
                alertController.addAction(CancelAction)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "Try again", style: .default) { (action) in
                    // handle response here.
                    self.fetchAllMovies()
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            } else if let data = data {
                // TODO: Get the array of movies
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                //print("Response \(dataDictionary)")
                // TODO: Store the movies in a property to use elsewhere
                self.movies = dataDictionary["results"] as? [NSDictionary]
                // TODO: Reload your table view data
                self.tableView.reloadData()
                // Stop the activity indicator
                // Hides automatically if "Hides When Stopped" is enabled
                self.activityIndicator.stopAnimating()
                self.refreshControl.endRefreshing()
            }
        }
        task.resume()*/
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        /*if let movies = movies {
            return movies.count
        }else{
             return 0
        }*/
        if self.searchBar.text!.isEmpty{
            return self.movies.count
        }else{
            return filter?.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MovieCell", for : indexPath) as! MovieCell
        cell.movies = movies[indexPath.row]
        /*let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        cell.titleLabel.text! = "\(title)"
        cell.overviewLabel.text! = overview
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        if let poster_path = movie["poster_path"] as? String {
            let imageUrl = NSURL(string: baseUrl+poster_path )
            cell.posterView.setImageWith(imageUrl! as URL)
        }
        */
        
        // Use a red color when the user selects the cell
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.cyan
        cell.selectedBackgroundView = backgroundView
        
        //print("Row \(indexPath.row)")
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print("Row \(indexPath.row)selected")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "nextVC") {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)
            let movie = movies[indexPath!.row]
            // Get the new view controller using segue.destinationViewController.
            let detailsViewController = segue.destination as! DetailsViewController
            // Pass the selected object to the new view controller.
//            detailsViewController.movie = movie
            //print(movie)
        }else{
            //print("segue not ok")
        }
    }
    
    /*func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(310)
    }*/
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
   
}
