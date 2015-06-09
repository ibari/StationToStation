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
}
