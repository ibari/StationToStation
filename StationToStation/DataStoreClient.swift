//
//  DataStoreClient.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/6/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class DataStoreClient {
    
    private static let vote_ClassName = "Vote"
    private static let vote_UserKey = "user_key"
    private static let vote_TrackKey = "track_key"
   
    func onApplicationLaunch() {
        let applicationId = Utils.sharedInstance.getSecret("parse_application_id")
        let clientKey = Utils.sharedInstance.getSecret("parse_client_key")
        
        Parse.setApplicationId(applicationId, clientKey: clientKey)
    }
    
    func getVotes(completion: (votes: [Vote]?, error: NSError?) -> Void) {
        var query: PFQuery = PFQuery(className: DataStoreClient.vote_ClassName)

        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if let error = error {
                completion(votes: nil, error: error)
                return
            }
            
            if let objects = objects as? [PFObject] {
                var votes = [Vote]()
                for obj in objects {
                    votes.append(self.pfoToVote(obj))
                }
                completion(votes: votes, error: nil)
            } else {
                completion(votes: [], error: nil)
                return
            }
        }
    }
    
    func saveVote(vote: Vote, completion: (success: Bool, error: NSError?) -> Void) {
        voteToPfo(vote).saveInBackgroundWithBlock(completion)
    }

    func pfoToVote(obj: PFObject) -> Vote {
        return Vote(
            userKey: obj[DataStoreClient.vote_UserKey] as! String,
            trackKey: obj[DataStoreClient.vote_TrackKey] as! String
        )
    }
    
    func voteToPfo(vote: Vote) -> PFObject {
        var obj = PFObject(className: DataStoreClient.vote_ClassName)
        
        obj[DataStoreClient.vote_UserKey] = vote.userKey
        obj[DataStoreClient.vote_TrackKey] = vote.trackKey
        
        return obj
    }
    
    class var sharedInstance: DataStoreClient {
        struct Static {
            static let instance = DataStoreClient()
        }
        return Static.instance
    }
}
