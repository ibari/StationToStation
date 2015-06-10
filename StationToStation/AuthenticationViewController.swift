//
//  AuthenticationViewController.swift
//  StationToStation
//
//  Created by Ian on 6/6/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController {
    @IBOutlet var loginButton: UIButton!
    
    var appDelegate: AppDelegate {
        get { return UIApplication.sharedApplication().delegate as! AppDelegate }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        appDelegate.rdioInstance.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTapSignIn(sender: AnyObject) {
        appDelegate.rdioInstance.logout()
        appDelegate.rdioInstance.authorizeFromController(self)
        
        /*RdioClient.sharedInstance.loginWithCompletion() { (user: User?, error: NSError?) in
        if user != nil {
            //self.performSegueWithIdentifier("loginSegue", sender: self)
            println("Login Successful!")
        } else {
            //handle error
            println("Login error: \(error)")
        }
        }*/
    }
}

// MARK: - RdioDelegate

extension AuthenticationViewController: RdioDelegate {
    func rdioDidAuthorizeUser(user: [NSObject : AnyObject]!, withAccessToken accessToken: String!) {
        if user != nil {
            //setLoggedIn(true)
            NSLog("Rdio authorized user")
            
            var storyboard = UIStoryboard(name: "Stations", bundle: nil)
            var viewController = storyboard.instantiateViewControllerWithIdentifier("StationsViewController") as! StationsViewController
            let navigationController = UINavigationController(rootViewController: viewController)
            self.presentViewController(navigationController, animated: true, completion: nil)
        } else {
            //handle error
            NSLog("Rdio authorizization failed")
        }
    }
    
    func rdioAuthorizationFailed(error: NSError!) {
        println("Rdio authorization failed with error: \(error.localizedDescription)")
        //setLoggedIn(false)
    }
    
    func rdioAuthorizationCancelled() {
        NSLog("Rdio authorization cancelled")
        //setLoggedIn(false)
    }
    
    func rdioDidLogout() {
        NSLog("Rdio did logout")
        //setLoggedIn(false)
    }
}

