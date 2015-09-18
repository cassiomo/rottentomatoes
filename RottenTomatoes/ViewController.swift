//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Mo, Kevin on 7/26/15.
//  Copyright (c) 2015 Mo, Kevin. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UITableViewController {
    
    var moviesArray: NSArray?
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        performAsyncMovieFetch()
    }
    
    func performAsyncMovieFetch() {
        
        let cachedDataUrl = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json")
        
        // Set the quality of service i.e. queue priority to perform the task off of the main queue
        let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
        // fetch the content of the url on a different queue other than the main queue (so that it does not block the UI)
        dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
            let rawMovieData = NSData(contentsOfURL: cachedDataUrl!)
            // Sending the results back to main queue to update UI using the fetched data
            dispatch_async(dispatch_get_main_queue()) {
                if rawMovieData != nil {
                    do {
                        if let dictionary = try NSJSONSerialization.JSONObjectWithData(rawMovieData!, options: NSJSONReadingOptions(rawValue: 0)) as? NSDictionary {
                            self.moviesArray = (dictionary["movies"] as! NSArray)
                            self.tableView.reloadData()
                        }
                    } catch _ {
                        print("Could not unwrap")
                    }
                } else {
                    print("Raw data is nil")
                }
            }
        }
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let array = moviesArray {
            return array.count
        } else {
            return 0
        }
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //let movie = self.moviesArray![indexPath.row] as! NSDictionary
        let movie = Movie(dictionary: moviesArray![indexPath.row] as! NSDictionary)
        
        let cell = tableView.dequeueReusableCellWithIdentifier("com.xzero.mycell") as! MovieTableViewCell
        
        cell.movieTitleLabel.text = movie.title as String
        
        let request = NSURLRequest(URL: movie.thumbnailURL)
        
        let cachedImage = UIImageView.sharedImageCache().cachedImageForRequest(request)
        
        if (cachedImage != nil) {
            cell.movieImageView.image = cachedImage
        } else {
            
            cell.movieImageView.setImageWithURLRequest(request, placeholderImage: nil, success: { (request, response, image) in
                cell.movieImageView.alpha = 0.0
                cell.movieImageView.image = image
                UIView.animateWithDuration(1.0, animations: {
                    cell.movieImageView.alpha = 1.0
                })
                }, failure: nil)
        }
        
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //NSLog("did tap row : \(indexPath.row)")
        let details = MovieDetailsViewController()
        let movie = self.moviesArray![indexPath.row] as! NSDictionary
        details.movieDictionary = movie
        self.navigationController?.pushViewController(details, animated: true)
    }
    
}

