//
//  People.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/8/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class People: NSObject {
 
    let key: String
    let username: String
    let profileImageUrl: String
    
    init(key: String, username: String, profileImageUrl: String) {
        self.key = key
        self.username = username
        self.profileImageUrl = profileImageUrl
    }
    
    class func search(phrase: String, completion: (peoples: [People]?, error: NSError?) -> Void) {
        completion(
            peoples: [
                People(key: "p1", username: "User_1", profileImageUrl: "http://upload.wikimedia.org/wikipedia/commons/9/9d/PalaceofFineArts1915.jpg"),
                People(key: "p2", username: "User_2", profileImageUrl: "http://upload.wikimedia.org/wikipedia/commons/9/9d/PalaceofFineArts1915.jpg"),
                People(key: "p3", username: "User_3", profileImageUrl: "http://upload.wikimedia.org/wikipedia/commons/9/9d/PalaceofFineArts1915.jpg")
            ],
            error: nil
        )
    }
}
