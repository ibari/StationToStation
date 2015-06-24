//
//  AuthenticationViewController.swift
//  StationToStation
//
//  Created by Ian on 6/6/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class AuthenticationViewController: UIViewController, RdioDelegate {
    @IBOutlet var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonAppearance()
        
        RdioClient.sharedInstance.delegate = self
        
        if User.currentUser != nil {
            NSLog("Current user: \(User.currentUser!.firstName) \(User.currentUser!.lastName)")
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTapSignIn(sender: AnyObject) {
        RdioClient.sharedInstance.authorizeFromController(self)
    }
    
    // MARK: - Configuration
    
    func setButtonAppearance() {
        loginButton.backgroundColor = UIColor.clearColor()
        loginButton.layer.cornerRadius = 12
        loginButton.layer.borderWidth = 1
        loginButton.layer.borderColor = UIColor(red: 0.0/255.0, green: 142.0/255.0, blue: 212.0/255.0, alpha: 1.0).CGColor
    }
    
    // MARK: - RdioDelegate
    
    func rdioDidAuthorizeUser(user: [NSObject : AnyObject]!) {
        if user != nil {
            NSLog("Rdio authorized user")
            
            User.currentUser = User(dictionary: user as NSDictionary)
            
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
