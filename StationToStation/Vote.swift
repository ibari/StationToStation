//
//  Vote.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/6/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

class Vote {
    
    let userKey: String
    let trackKey: String
    
    init(userKey: String, trackKey: String) {
        self.userKey = userKey
        self.trackKey = trackKey
    }
    
    func save(completion: (success: Bool, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.saveVote(self, completion: completion)
    }
    
    class func loadAll(completion: (vote: [Vote]?, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.getVotes(completion)
    }
}
