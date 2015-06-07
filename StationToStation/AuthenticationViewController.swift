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
        
        loginButton.addTarget(self, action: "onLogin", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func onLogin() {
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
