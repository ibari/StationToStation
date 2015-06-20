//
//  User.swift
//  StationToStation
//
//  Created by Ian on 6/6/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

var _currentUser: User?
let currentUserKey = "kCurrentUserKey"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"

class User: NSObject {
    var key: String!
    var firstName: String!
    var lastName: String!
    var profileImageUrl: NSURL!
    var dictionary: NSDictionary!
    var isCollaborator: Bool?
    
    init(dictionary: NSDictionary) {
        self.key = dictionary["key"] as! String
        self.firstName = dictionary["firstName"] as! String
        self.lastName = dictionary["lastName"] as! String
        self.profileImageUrl = NSURL(string: (dictionary["icon"] as! String))
        self.dictionary = dictionary
    }
    
    func logout() {
        User.currentUser = nil
        NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
    }
    
    class var currentUser: User? {
        get {
            if _currentUser == nil {
                var data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
                
                if data != nil {
                var dictionary = NSJSONSerialization.JSONObjectWithData(data!, options: nil, error: nil) as! NSDictionary
                _currentUser = User(dictionary: dictionary)
            }
        }
        
        return _currentUser
        }
        
        set(user) {
            _currentUser = user
            
            if _currentUser != nil {
                var data = NSJSONSerialization.dataWithJSONObject(user!.dictionary!, options: nil, error: nil)
                NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey)
            } else {
                NSUserDefaults.standardUserDefaults().setObject(nil, forKey: currentUserKey)
            }
            
            NSUserDefaults.standardUserDefaults().synchronize()
        }
    }
    
    class func search(phrase: String, completion: (user: User?, error: NSError?) -> Void) {
        RdioClient.sharedInstance.searchUser(phrase, completion: completion)
    }
    
    func isCollaborator(station: Station, completion: (collaborator: Bool?, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.isCollaborator(self, station: station, completion: completion)
    }
    
    func collaborate(station: Station, completion: (success: Bool, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.saveCollaborator(self, station: station, completion: completion)
    }
    
    func uncollaborate(station: Station, completion: (success: Bool, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.deleteCollaborator(self, station: station, completion: completion)
    }
}



