//
//  TabSwitchViewController.swift
//  RottenTomatoes
//
//  Created by Mo, Kevin on 9/20/15.
//  Copyright © 2015 Mo, Kevin. All rights reserved.
//

import UIKit

class TabSwitchViewController : UIViewController {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let viewController = segue.destinationViewController as! ViewController
        switch restorationIdentifier! {
            case "movieTab":
                viewController.tab = .MovieTab
            default:
                viewController.tab = .DVDTab
            }
    }
}
