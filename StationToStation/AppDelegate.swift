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
        DataStoreClient.sharedInstance.onApplicationLaunch()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: userDidLogoutNotification, object: nil)

        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let rootController = storyboard.instantiateInitialViewController() as! UIViewController
        self.window!.rootViewController = rootController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func userDidLogout() {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let rootController = storyboard.instantiateInitialViewController() as! UIViewController
        self.window!.rootViewController = rootController
    }
}

