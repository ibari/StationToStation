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
    
    // MARK: - Station
    
    private static let station_ClassName = "Station"
    private static let station_ObjectId = "objectId"
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
    
    func getStations(ids: [String], completion: (stations: [Station]?, error: NSError?) -> Void) {
        var query: PFQuery = PFQuery(className: DataStoreClient.station_ClassName)
        query.whereKey("objectId", containedIn: ids)
        
        query.findObjectsInBackgroundWithBlock { (objs: [AnyObject]?, error: NSError?) -> Void in
            if let error = error {
                completion(stations: nil, error: error)
                return
            }
            
            var stations = [Station]()
            for obj in objs! {
                stations.append(self.pfoToStation(obj as! PFObject))
            }
            completion(stations: stations, error: nil)
        }
    }
    
    func getInvitedStations(completion: (stations: [Station]?, error: NSError?) -> Void) {
        var query: PFQuery = PFQuery(className: DataStoreClient.invite_ClassName)
        
        query.whereKey(DataStoreClient.invite_toUserKey, equalTo: User.currentUser!.key)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if let error = error {
                completion(stations: nil, error: error)
                return
            }
            
            if let objects = objects as? [PFObject] {
                var stationIds = [String]()
                for obj in objects {
                    stationIds.append(obj["stationObjectId"] as! String)
                }
                self.getStations(stationIds, completion: completion)
                return
            } else {
                completion(stations: [], error: nil)
                return
            }
        }
    }
    
    class func loadAll(completion: (stations: [Station]?, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.getStations(completion)
    }
    
    func getStation(objectId: String, completion: (station: Station?, error: NSError?) -> Void) {
        var query: PFQuery = PFQuery(className: DataStoreClient.station_ClassName)
    
        query.getObjectInBackgroundWithId(objectId) { (obj: PFObject?, error: NSError?) -> Void in
            if error == nil && obj != nil {
                let stationObj = self.pfoToStation(obj!)
                completion(station: stationObj, error: nil)
            } else {
                completion(station: nil, error: error)
            }
        }
    }
    
    func saveStation(station: Station, completion: (success: Bool, error: NSError?) -> Void) {
        stationToPfo(station).saveInBackgroundWithBlock(completion)
    }
    
    func pfoToStation(obj: PFObject) -> Station {
        let station = Station(
            ownerKey: obj[DataStoreClient.station_OwnerKey] as! String,
            playlistKey: obj[DataStoreClient.station_PlaylistKey] as! String,
            name: obj[DataStoreClient.station_Name] as! String,
            description: obj[DataStoreClient.station_Description] as! String,
            imageUrl: obj[DataStoreClient.station_ImageUrl] as! String
        )
        
        station.objectId = obj.objectId!
        
        return station
    }
    
    func stationToPfo(station: Station) -> PFObject {
        var obj = PFObject(className: DataStoreClient.station_ClassName)
        
        obj[DataStoreClient.station_OwnerKey] = station.ownerKey
        obj[DataStoreClient.station_PlaylistKey] = station.playlistKey
        obj[DataStoreClient.station_Name] = station.name
        obj[DataStoreClient.station_Description] = station.description
        obj[DataStoreClient.station_ImageUrl] = station.imageUrl
        
        return obj
    }
    
    // MARK: - Vote
    
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
    
    // MARK: - Invite
    
    private static let invite_ClassName = "Invite"
    private static let invite_fromUserKey = "fromUserKey"
    private static let invite_toUserKey = "toUserkey"
    private static let invite_stationObjectId = "stationObjectId"
    private static let invite_accepted = "accepted"
    
    func getInvites(completion: (invites: [Invite]?, error: NSError?) -> Void) {
        var query: PFQuery = PFQuery(className: DataStoreClient.invite_ClassName)
        
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if let error = error {
                completion(invites: nil, error: error)
                return
            }
            
            if let objects = objects as? [PFObject] {
                var invites = [Invite]()
                for obj in objects {
                    invites.append(self.pfoToInvite(obj))
                }
                completion(invites: invites, error: nil)
            } else {
                completion(invites: [], error: nil)
                return
            }
        }
    }
    
    func saveInvite(invite: Invite, completion: (success: Bool, error: NSError?) -> Void) {
        inviteToPfo(invite).saveInBackgroundWithBlock(completion)
    }
    
    func pfoToInvite(obj: PFObject) -> Invite {
        return Invite(
            fromUserKey: obj[DataStoreClient.invite_fromUserKey] as! String,
            toUserKey: obj[DataStoreClient.invite_toUserKey] as! String,
            stationObjectId: obj[DataStoreClient.invite_stationObjectId] as! String,
            accepted: obj[DataStoreClient.invite_accepted] as! Bool
        )
    }
    
    func inviteToPfo(invite: Invite) -> PFObject {
        var obj = PFObject(className: DataStoreClient.invite_ClassName)
        
        obj[DataStoreClient.invite_fromUserKey] = invite.fromUserKey
        obj[DataStoreClient.invite_toUserKey] = invite.toUserKey
        obj[DataStoreClient.invite_stationObjectId] = invite.stationObjectId
        obj[DataStoreClient.invite_accepted] = invite.accepted
        
        return obj
    }
}
