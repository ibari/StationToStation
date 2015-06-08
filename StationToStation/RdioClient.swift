//
//  RdioClient.swift
//  StationToStation
//
//  Created by Ian on 6/6/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

let rdioClientID = ""
let rdioSecret = ""
let rdioBaseURL = NSURL(string: "https://api.rdio.com")

class RdioClient: AFOAuth2Manager {
    var loginCompletion: ((user: User?, error: NSError?) -> ())?
    
    class var sharedInstance: RdioClient {
        struct Static {
            static let instance = RdioClient(baseURL: rdioBaseURL, clientID: rdioClientID, secret: rdioSecret)
        }
        
        return Static.instance
    }
    
    func loginWithCompletion(controller: UIViewController, completion: (user: User?, error: NSError?) -> ()) {
        loginCompletion = completion
        
        //RdioClient.sharedInstance.requestSerializer.removeAccessToken()
        RdioClient.sharedInstance.authenticateUsingOAuthWithURLString("https://services.rdio.com/oauth2/token", scope: "", success: { (credential: AFOAuthCredential!) -> Void in
            var authURL = NSURL(string: "https://www.rdio.com/oauth2/authorize?oauth_token=\(credential.accessToken)")

            println("Got the request token")
            //UIApplication.sharedApplication().openURL(authURL!)
            }) { (error: NSError!) -> Void in
                println("Failed to get request token")
                self.loginCompletion?(user: nil, error: error)
        }
    }
    
    /*func openURL(url: NSURL) {
        fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query), success: { (accessToken: BDBOAuth1Credential!) -> Void in
            println("Got the access token")
            TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
            
            TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil
                , success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
                    var user = User(dictionary: response as! NSDictionary)
                    User.currentUser = user
                    self.loginCompletion?(user: user, error: nil)
                }, failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
                    println("Failed to get current user")
                    self.loginCompletion?(user: nil, error: error)
            })
            }) { (error: NSError!) -> Void in
                println("Failed to receive access token")
                self.loginCompletion?(user: nil, error: error)
        }
    }*/
}
