//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Mo, Kevin on 7/26/15.
//  Copyright (c) 2015 Mo, Kevin. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

enum tabView {
    case MovieTab, DVDTab
}

class ViewController: UITableViewController {
    
    var moviesArray: NSArray?
    var movieRefreshControl: UIRefreshControl!
    var tab : tabView = .MovieTab
    var cachedDataUrl : NSURL?
    
    @IBOutlet weak var networkErrorView: UIView!
    @IBOutlet weak var networkErrorLabel: UILabel!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        self.navigationItem.title = "Box Office"
        
        movieRefreshControl = UIRefreshControl()
        movieRefreshControl.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
        self.tableView.insertSubview(movieRefreshControl, atIndex: 0)
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        performAsyncMovieFetch()
        MBProgressHUD.hideAllHUDsForView(self.view, animated:true)
    }
    
    func performAsyncMovieFetch() {
        
        let movieDataUrl = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/d1778ca5b944ed974db0/raw/489d812c7ceeec0ac15ab77bf7c47849f2d1eb2b/gistfile1.json")
        
        let dvdDataUrl = NSURL(string: "https://gist.githubusercontent.com/timothy1ee/e41513a57049e21bc6cf/raw/b490e79be2d21818f28614ec933d5d8f467f0a66/gistfile1.json")
        
        switch tab  {
            case .DVDTab:
                cachedDataUrl = dvdDataUrl
                break
            default:
                cachedDataUrl = movieDataUrl
        }
        
        
        // Set the quality of service i.e. queue priority to perform the task off of the main queue
        let qos = Int(QOS_CLASS_USER_INITIATED.rawValue)
        
        self.showNetworkError(false)
        // fetch the content of the url on a different queue other than the main queue (so that it does not block the UI)
        dispatch_async(dispatch_get_global_queue(qos, 0)) { () -> Void in
            let rawMovieData = NSData(contentsOfURL: self.cachedDataUrl!)
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
                    NSLog("NetworkError:")
                    self.showNetworkError(true)
                }
            }
        }
    }
    
    func showNetworkError(show: Bool) {
        if !show {
            networkErrorLabel.hidden = !show
            networkErrorView.hidden = !show
        } else {
            networkErrorLabel.bringSubviewToFront(networkErrorView)
            networkErrorLabel.hidden = show
            networkErrorView.hidden = show
        }
    }
    
    func delay(delay:Double, closure:()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(), closure)
    }
    
    func onRefresh() {
        delay(2, closure: {
            self.movieRefreshControl.endRefreshing()
        })
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
        
        cell.movieRating.text = movie.mpaaRating as String
        cell.movieDescriptionLabel.text = movie.synopsis as String
        cell.movieDescriptionLabel.numberOfLines = 0
        cell.movieDescriptionLabel.sizeToFit()
        
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
    
//    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        //NSLog("did tap row : \(indexPath.row)")
//        let details = MovieDetailsViewController()
//        let movie = self.moviesArray![indexPath.row] as! NSDictionary
//        details.movieDictionary = movie
//        self.navigationController?.pushViewController(details, animated: true)
//    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "details" {
            let controller = segue.destinationViewController as! MovieDetailsViewController
            let indexPath = self.tableView.indexPathForSelectedRow!
            let movie = Movie(dictionary: moviesArray![indexPath.row] as! NSDictionary)
            controller.movie = movie
            print("OK")
            print(controller.movie?.title)

        }
    }
    
}

