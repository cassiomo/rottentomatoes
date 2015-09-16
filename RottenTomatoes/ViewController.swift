//
//  ViewController.swift
//  RottenTomatoes
//
//  Created by Mo, Kevin on 7/26/15.
//  Copyright (c) 2015 Mo, Kevin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var moviesArray: NSArray?

    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let YourApiKey = "9htuhtcb4ymusd73d4z6jxcj" // Fill with the key you registered at http://developer.rottentomatoes.com
        let RottenTomatoesURLString = "http://api.rottentomatoes.com/api/public/v1.0/lists/dvds/top_rentals.json?apikey=" + YourApiKey
        let request = NSMutableURLRequest(URL: NSURL(string :RottenTomatoesURLString)!)
        
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler:{ (response, data, error) in
//            var errorValue: NSError? = nil
            //let dictionary = NSJSONSerialization.JSONObjectWithData(<#T##data: NSData##NSData#>, options: <#T##NSJSONReadingOptions#>)
            //let dictionary = NSJSONSerialization.JSONObjectWithData(data, options: nil, error: &errorValue) as NSDictionary
            //self.moviesArray = (dictionary["movies"] as! NSArray)
            //self.tableView.reloadData()
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
        let movie = self.moviesArray![indexPath.row] as! NSDictionary
        let cell = tableView.dequeueReusableCellWithIdentifier("com.xzero.mycell") as! MovieTableViewCell
        cell.movieTitleLabel.text = movie["title"] as! NSString as String
        
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

