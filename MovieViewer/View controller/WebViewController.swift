//
//  WebViewController.swift
//  MovieViewer
//
//  Created by Djason  Sylvaince on 9/25/18.
//  Copyright © 2018 Djason  Sylvaince. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController {
    @IBOutlet weak var webkitView: WKWebView!
    
    var movie: NSDictionary!
    var videos: [NSDictionary]?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        ///**Above** the `viewDidLoad` method, create a constant to hold your URL string. We will link to the DropBox mobile terms url.
        fetchAllYoutube()
    }

    func fetchAllYoutube(){
        
        let idSelected = movie["id"] as! NSNumber
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(idSelected)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed&language=en-US")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print("ERROR: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Cannot get trailer", message: "The internet connection appears to be offline", preferredStyle: .alert)
                
                // create an OK action
                let CancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
                    // handle response here.
                    
                }
                // add the OK action to the alert controller
                alertController.addAction(CancelAction)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "Try again", style: .default) { (action) in
                    // handle response here.
                    self.fetchAllYoutube()
                }
                // add the OK action to the alert controller
                alertController.addAction(OKAction)
                self.present(alertController, animated: true) {
                    // optional code for what happens after the alert controller has finished presenting
                }
            } else if let data = data {
                // TODO: Get the array of movies
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                // TODO: Store the movies in a property to use elsewhere
                self.videos = dataDictionary["results"] as? [NSDictionary]
                
                let video = self.videos![0]
                let id = video["id"] as! String
                let key = video["key"] as! String
                let name = video["name"] as! String
                
                //link to the DropBox mobile terms url.
                
                let url = "https://www.youtube.com/embed/\(key)?autoplay=1"
                print(url)
                // Convert the url String to a NSURL object.
                let requestURL = URL(string:url)
                // Place the URL in a URL Request.
                let request = URLRequest(url: requestURL!)
                self.webkitView.load(request)
                
                
            }
        }
        task.resume()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
