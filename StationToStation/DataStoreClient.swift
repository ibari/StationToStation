//
//  DataStoreClient.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/6/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class DataStoreClient {
    
    func onApplicationLaunch() {
        let applicationId = Utils.sharedInstance.getSecret("parse_application_id")
        let clientKey = Utils.sharedInstance.getSecret("parse_client_key")
        
        Parse.setApplicationId(applicationId, clientKey: clientKey)
    }
    
    class var sharedInstance: DataStoreClient {
        struct Static {
            static let instance = DataStoreClient()
        }
        return Static.instance
    }
    
    // MARK: - VOTE
    
    private static let vote_ClassName = "Vote"
    private static let vote_UserKey = "user_key"
    private static let vote_TrackKey = "track_key"
    
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
    
    // MARK: - STATION
    
    private static let station_ClassName = "Station"
    private static let station_OwnerKey = "owner_key"
    private static let station_PlaylistKey = "playlist_key"
    private static let station_Name = "name"
    private static let station_Description = "description"
    private static let station_ImageUrl = "image_url"
    
    func getStations(completion: (stations: [Station]?, error: NSError?) -> Void) {
        var query: PFQuery = PFQuery(className: DataStoreClient.station_ClassName)
        query.whereKey(DataStoreClient.station_OwnerKey, equalTo: User.currentUser!.key)
        
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if let error = error {
                completion(stations: nil, error: error)
                return
            }
            
            if let objects = objects as? [PFObject] {
                var stations = [Station]()
                for obj in objects {
                    stations.append(self.pfoToStation(obj))
                }
                completion(stations: stations, error: nil)
            } else {
                completion(stations: [], error: nil)
                return
            }
        }
    }
    
    func saveStation(station: Station, completion: (success: Bool, error: NSError?) -> Void) {
        stationToPfo(station).saveInBackgroundWithBlock(completion)
    }
    
    func pfoToStation(obj: PFObject) -> Station {
        return Station(
            ownerKey: obj[DataStoreClient.station_OwnerKey] as! String,
            playlistKey: obj[DataStoreClient.station_PlaylistKey] as! String,
            name: obj[DataStoreClient.station_Name] as! String,
            description: obj[DataStoreClient.station_Description] as! String,
            imageUrl: obj[DataStoreClient.station_ImageUrl] as! String
        )
    }
    
    func stationToPfo(s: Station) -> PFObject {
        var obj = PFObject(className: DataStoreClient.station_ClassName)
        
        obj[DataStoreClient.station_OwnerKey] = s.ownerKey
        obj[DataStoreClient.station_PlaylistKey] = s.playlistKey
        obj[DataStoreClient.station_Name] = s.name
        obj[DataStoreClient.station_Description] = s.description
        obj[DataStoreClient.station_ImageUrl] = s.imageUrl
        
        return obj
    }
}
