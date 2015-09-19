//
//  MovieDetailsViewController.swift
//  RottenTomatoes
//
//  Created by Mo, Kevin on 7/27/15.
//  Copyright (c) 2015 Mo, Kevin. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {

    var movieDictionary: NSDictionary?
    var movie : Movie?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func loadView() {
        let myView = UIView(frame: CGRectZero)
        myView.backgroundColor = UIColor.greenColor()
        self.view = myView
    }

}
