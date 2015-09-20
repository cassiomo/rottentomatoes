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

    var year: NSNumber {
        get {
            return diction["year"] as! NSNumber
        }
    }
    
    var title : NSString {
        get {
            return diction["title"] as! NSString
        }
    }
    
    var ratings: NSDictionary {
        get {
            return diction["ratings"] as! NSDictionary
        }
    }
    
    
    var criticsScore : NSNumber {
        get {
            return self.ratings["critics_score"] as! NSNumber
        }
    }
    
    var audienceScore : NSNumber {
        get {
            return self.ratings["audience_score"] as! NSNumber
        }
    }
    
    var mpaaRating : NSString {
        get {
            return diction["mpaa_rating"] as! NSString
        }
    }
    
    var synopsis: NSString {
        get {
            return diction["synopsis"] as! NSString
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
    
    var posterURL : NSURL {
        get {
            return NSURL(string: (self.posters["original"] as! NSString).stringByReplacingOccurrencesOfString("tmb", withString: "ori"))!
        }
    }
}
