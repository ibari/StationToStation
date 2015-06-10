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
    
    private let rdioClientId = Utils.sharedInstance.getSecret("sts_client_id")
    private let rdioClientSecret = Utils.sharedInstance.getSecret("sts_client_secret")
    
    var window: UIWindow?
    
    lazy internal var rdioInstance: Rdio = {
        return Rdio(clientId: self.rdioClientId, andSecret: self.rdioClientSecret, delegate: nil);
    }()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        DataStoreClient.sharedInstance.onApplicationLaunch()
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "userDidLogout", name: userDidLogoutNotification, object: nil)
        
        if User.currentUser != nil {
            NSLog("Current user: \(User.currentUser!.firstName!) \(User.currentUser!.lastName!)")
        } 
        
        window = UIWindow(frame: UIScreen.mainScreen().bounds)
        let storyboard = UIStoryboard(name: "Test", bundle: nil)
        let rootController = storyboard.instantiateInitialViewController() as! UIViewController
//        let rootController = storyboard.instantiateViewControllerWithIdentifier("TestViewController") as! UIViewController
        self.window!.rootViewController = rootController
        window?.makeKeyAndVisible()
        
        return true
    }
    
    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
}

