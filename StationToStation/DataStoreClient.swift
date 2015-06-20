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
    private static let station_PlaylistMeta = "playlist_meta"
    
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
                    stationIds.append(obj[DataStoreClient.invite_stationObjectId] as! String)
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
        if let objectId = station.objectId {
            // Update
            let pfo = stationToPfo(station)
            pfo.objectId = objectId
            pfo.saveInBackgroundWithBlock(completion)
        } else {
            // Create
            stationToPfo(station).saveInBackgroundWithBlock(completion)
        }
    }
    
    func pfoToStation(obj: PFObject) -> Station {
        let station = Station(
            ownerKey: obj[DataStoreClient.station_OwnerKey] as! String,
            playlistKey: obj[DataStoreClient.station_PlaylistKey] as! String,
            name: obj[DataStoreClient.station_Name] as! String,
            description: obj[DataStoreClient.station_Description] as! String,
            imageUrl: obj[DataStoreClient.station_ImageUrl] as! String,
            playlistMetaDict: obj[DataStoreClient.station_PlaylistMeta] as? [String: AnyObject]
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
        obj[DataStoreClient.station_PlaylistMeta] = station.playlistMeta.getData()
        
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
    
    // MARK: - Collaborator
    
    private static let collaborator_ClassName = "Collaborator"
    private static let collaborator_objectId = "objectId"
    private static let collaborator_userKey = "userKey"
    private static let collaborator_stationObjectId = "stationObjectId"
    
    func getCollaborators(station: Station, completion: (users: [User]?, error: NSError?) -> Void) {
        var query: PFQuery = PFQuery(className: DataStoreClient.collaborator_ClassName)

        query.whereKey(DataStoreClient.collaborator_stationObjectId, equalTo: station.objectId!)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if let error = error {
                completion(users: nil, error: error)
                return
            }
            
            if let objects = objects as? [PFObject] {
                var userKeys = [String]()
                for obj in objects {
                    userKeys.append(obj[DataStoreClient.collaborator_userKey] as! String)
                }
                RdioClient.sharedInstance.getUsers(userKeys, completion: completion)
                return
            } else {
                completion(users: [], error: nil)
                return
            }
        }
    }
    
    func saveCollaborator(collaborator: User, station: Station, completion: (success: Bool, error: NSError?) -> Void) {
        collaboratorToPfo(collaborator, station: station).saveInBackgroundWithBlock(completion)
    }
    
    func deleteCollaborator(collaborator: User, station: Station, completion: (success: Bool, error: NSError?) -> Void) {
        var query: PFQuery = PFQuery(className: DataStoreClient.collaborator_ClassName)
    
        query.whereKey(DataStoreClient.collaborator_userKey, equalTo: collaborator.key)
        query.whereKey(DataStoreClient.collaborator_stationObjectId, equalTo: station.objectId!)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if let error = error {
                completion(success: false, error: error)
                return
            }
            
            if let objects = objects as? [PFObject] {
                for obj in objects {
                    obj.deleteInBackgroundWithBlock(completion)
                }
            } else {
                completion(success: false, error: nil)
                return
            }
        }
    }
    
    func collaboratorToPfo(collaborator: User, station: Station) -> PFObject {
        var obj = PFObject(className: DataStoreClient.collaborator_ClassName)
        
        obj[DataStoreClient.collaborator_userKey] = collaborator.key
        obj[DataStoreClient.collaborator_stationObjectId] = station.objectId
        
        return obj
    }
    
    func isCollaborator(user: User, station: Station, completion: (collaborator: Bool?, error: NSError?) -> Void) {
        var query: PFQuery = PFQuery(className: DataStoreClient.collaborator_ClassName)
        
        query.whereKey(DataStoreClient.collaborator_userKey, equalTo: user.key)
        query.whereKey(DataStoreClient.collaborator_stationObjectId, equalTo: station.objectId!)
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]?, error: NSError?) -> Void in
            if let error = error {
                completion(collaborator: nil, error: error)
                return
            }
            
            if let objects = objects as? [PFObject] {
                var collaborators = [String]()
                
                for obj in objects {
                    collaborators.append(obj[DataStoreClient.collaborator_userKey] as! String)
                }
                
                let collaborator = (collaborators.first != nil) ? true : false
                completion(collaborator: collaborator, error: nil)
                return
            } else {
                completion(collaborator: false, error: nil)
                return
            }
        }
    }
}
