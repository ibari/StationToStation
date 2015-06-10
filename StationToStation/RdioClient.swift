//
//  RdioClient.swift
//  StationToStation
//
//  Created by Ian on 6/6/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class RdioClient: RdioDelegate {
    
    private var rdio: Rdio!
    
    private let rdioClientId = Utils.sharedInstance.getSecret("sts_client_id")
    private let rdioClientSecret = Utils.sharedInstance.getSecret("sts_client_secret")
    
    class var sharedInstance: RdioClient {
        struct Static {
            static let instance = RdioClient()
        }
        return Static.instance
    }
    
    init() {
        rdio = Rdio(clientId: rdioClientId, andSecret: rdioClientSecret, delegate: self)
    }
    
    func login(vc: UIViewController) {
        NSLog("Rdio did login")
        rdio.authorizeFromController(vc)
    }
    
    // MARK: - RdioDelegate
    
    func rdioDidAuthorizeUser(user: [NSObject : AnyObject]!) {
        NSLog("Rdio authorized user")
    }
    
    func rdioDidAuthorizeUser(user: [NSObject : AnyObject]!, withAccessToken accessToken: String!) {
        NSLog("Rdio authorized user with access token")
    }
    
    func rdioAuthorizationCancelled() {
        NSLog("Rdio authorization cancelled")
    }
    
    func rdioAuthorizationFailed(error: NSError!) {
        NSLog("Rdio authorization failed")
    }
    
    func rdioDidLogout() {
        NSLog("Rdio did logout")
    }
}
