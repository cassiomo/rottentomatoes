//
//  Movie.swift
//  RottenTomatoes
//
//  Created by Mo, Kevin on 9/17/15.
//  Copyright © 2015 Mo, Kevin. All rights reserved.
//

import Foundation
import UIKit

class Movie : NSObject {
    
    var diction : NSDictionary
    
    init(dictionary : NSDictionary) {
        self.diction = dictionary
    }
    
    var title : NSString {
        get {
            return diction["title"] as! NSString
        }
    }
    
    var posters: NSDictionary {
        get {
            return diction["posters"] as! NSDictionary
        }
    }
    
    var thumbnailURL: NSURL {
        get {
            return NSURL(string: (self.posters["detailed"] as! NSString).stringByReplacingOccurrencesOfString("tmb", withString: "det"))!
        }
    }
}