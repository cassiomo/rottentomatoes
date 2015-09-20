//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Mo, Kevin on 7/27/15.
//  Copyright (c) 2015 Mo, Kevin. All rights reserved.
//

import UIKit
import AFNetworking

class MovieDetailsViewController: UIViewController {

    var movieDictionary: NSDictionary?
    var movie : Movie?
    
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieScore: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieSynopsis: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = movie!.title as String
        movieTitle.text = movie!.title as String
        movieScore.text = "Critics Score: \(movie!.criticsScore), Audience Score:  \(movie!.audienceScore)"
        movieRating.text = movie!.mpaaRating as String
        movieSynopsis.text = movie!.synopsis as String
        movieSynopsis.sizeToFit()
        
        let request = NSURLRequest(URL: movie!.posterURL)
        let cachedImage = UIImageView.sharedImageCache().cachedImageForRequest(request)
        if (cachedImage != nil) {
            posterImage.image = cachedImage
        } else {
            posterImage.setImageWithURL(movie!.thumbnailURL)
            posterImage.setImageWithURLRequest(request, placeholderImage: nil, success: { (request, response, image) in
                }, failure: nil)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
