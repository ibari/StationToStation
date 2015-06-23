//
//  Comment.swift
//  StationToStation
//
//  Created by Ian on 6/21/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

class Comment {
    
    let stationObjectId: String?
    let trackKey: String?
    let userKey: String?
    let text: String?
    
    var user: User?
    
    init(stationObjectId: String, trackKey: String, userKey: String, text: String) {
        self.stationObjectId = stationObjectId
        self.trackKey = trackKey
        self.userKey = userKey
        self.text = text
    }
    
    func save(completion: (success: Bool, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.saveComment(self, completion: completion)
    }
}

