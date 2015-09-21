//
//  TabSwitchViewController.swift
//  RottenTomatoes
//
//  Created by Mo, Kevin on 9/20/15.
//  Copyright © 2015 Mo, Kevin. All rights reserved.
//

import UIKit

class TabSwitchViewController : UIViewController {
    
    
    var searchBar : UISearchBar!
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        
//        searchBar = UISearchBar(frame: CGRectMake(0.0, -80.0, 320.0, 44.0))
//        navigationController?.navigationBar.addSubview(searchBar)
//        
//        var button = UIBarButtonItem(image: <#T##UIImage?#>, style: <#T##UIBarButtonItemStyle#>, target: <#T##AnyObject?#>, action: <#T##Selector#>)
//
//        self.navigationItem.rightBarButtonItem = button
//    }
//
//    override func showViewController(vc: UIViewController, sender: AnyObject?) {
//        //searchBar.frame = CGRectMake(0.0, 0, 320, 44)
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        //searchBar.removeFromSuperview()
//    }
    
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
