//
//  AppDelegate.swift
//  StationToStation
//
//  Created by Ian on 6/4/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        setAppearance()
        
        DataStoreClient.sharedInstance.onApplicationLaunch()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: userDidLogoutNotification, object: nil)

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let rootController = storyboard.instantiateInitialViewController() as! UIViewController
        self.window!.rootViewController = rootController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func setAppearance() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.0/255.0, green: 142.0/255.0, blue: 212.0/255.0, alpha: 1.0)
        UINavigationBar.appearance().titleTextAttributes = [NSForegroundColorAttributeName : UIColor.whiteColor()]
        
        let navBarFont = UIFont(name: "HelveticaNeue", size:15.0)!
        UIBarButtonItem.appearance().setTitleTextAttributes([NSFontAttributeName:navBarFont,NSForegroundColorAttributeName:UIColor.whiteColor()], forState: UIControlState.Normal)
        
        let tabBarFont = UIFont(name: "HelveticaNeue", size:12.0)!
        UITabBarItem.appearance().setTitleTextAttributes([NSFontAttributeName:tabBarFont,NSForegroundColorAttributeName:UIColor.darkGrayColor()], forState: UIControlState.Normal)
    }
    
    func userDidLogout() {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let rootController = storyboard.instantiateInitialViewController() as! UIViewController
        self.window!.rootViewController = rootController
    }
}

