//
//  MovieTableViewCell.swift
//  RottenTomatoes
//
//  Created by Mo, Kevin on 7/26/15.
//  Copyright (c) 2015 Mo, Kevin. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieDescriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let backgroundView = UIView()
        self.selectionStyle = .Default
        backgroundView.backgroundColor = .None
        self.selectedBackgroundView = backgroundView
    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }

}
