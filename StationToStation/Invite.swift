//
//  Invite.swift
//  StationToStation
//
//  Created by Ian Bari on 6/6/16.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

class Invite {
    
    let fromUserKey: String
    let toUserKey: String
    let stationObjectId: String
    let accepted: Bool
    
    init(fromUserKey: String, toUserKey: String, stationObjectId: String, accepted: Bool) {
        self.fromUserKey = fromUserKey
        self.toUserKey = toUserKey
        self.stationObjectId = stationObjectId
        self.accepted = accepted
    }
    
    func save(completion: (success: Bool, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.saveInvite(self, completion: completion)
    }
    
    class func loadAll(completion: (invite: [Invite]?, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.getInvites(completion)
    }
}
