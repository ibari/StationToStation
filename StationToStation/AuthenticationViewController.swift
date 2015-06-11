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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        RdioClient.sharedInstance.delegate = self
        
        if User.currentUser != nil {
            NSLog("Current user: \(User.currentUser!.firstName!) \(User.currentUser!.lastName!)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTapSignIn(sender: AnyObject) {
        RdioClient.sharedInstance.authorizeFromController(self)
    }
}

// MARK: - RdioDelegate

extension AuthenticationViewController: RdioDelegate {
    func rdioDidAuthorizeUser(user: [NSObject : AnyObject]!, withAccessToken accessToken: String!) {
        if user != nil {
            NSLog("Rdio authorized user")
        
            User.currentUser = User(dictionary: user as NSDictionary)
            User.currentUser?.accessToken = accessToken
            
            var storyboard = UIStoryboard(name: "Main", bundle: nil)
            var viewController = storyboard.instantiateViewControllerWithIdentifier("TabBarViewController") as! TabBarViewController
            let navigationController = UINavigationController(rootViewController: viewController)
            self.presentViewController(navigationController, animated: true, completion: nil)
        }
    }
    
    func rdioAuthorizationFailed(error: NSError!) {
        NSLog("Rdio authorization failed: \(error.localizedDescription)")
        User.currentUser?.logout()
    }
    
    func rdioAuthorizationCancelled() {
        NSLog("Rdio authorization cancelled")
        User.currentUser?.logout()
    }
    
    func rdioDidLogout() {
        NSLog("Rdio did logout")
        User.currentUser?.logout()
    }
}

