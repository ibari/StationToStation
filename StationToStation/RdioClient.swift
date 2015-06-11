//
//  RdioClient.swift
//  StationToStation
//
//  Created by Ian on 6/6/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class RdioClient: Rdio {
    
    private var rdio: Rdio!
    private let rdioClientId = Utils.sharedInstance.getSecret("sts_client_id")
    private let rdioClientSecret = Utils.sharedInstance.getSecret("sts_client_secret")
    
    class var sharedInstance: RdioClient {
        struct Static {
            static let instance = RdioClient()
        }
        
        return Static.instance
    }
    
    override init() {
        super.init(clientId: self.rdioClientId, andSecret: self.rdioClientSecret, delegate: nil)
    }
}
