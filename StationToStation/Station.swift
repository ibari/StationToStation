//
//  Station.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/7/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class Station {
   
    let ownerKey: String!
    let playlistKey: String!
    let name: String!
    let description: String!
    let imageUrl: String!
    
    init(ownerKey: String, playlistKey: String, name: String, description: String, imageUrl: String) {
        self.ownerKey = ownerKey
        self.playlistKey = playlistKey
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
    }
 
    func save(completion: (success: Bool, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.saveStation(self, completion: completion)
    }
    
    func getPlaylist(completion: (playlist: Playlist?, error: NSError?) -> Void) {
        RdioClient.sharedInstance.getPlaylist(playlistKey, completion: completion)
    }
    
    func inviteCollaborator(collaborator: User, completion: (success: Bool?, error: NSError?) -> Void) {
        completion(success: true, error: nil)
    }
    
    func getCollaborators(completion: (collaborators: [User]?, error: NSError?) -> Void) {
        /*completion(
            collaborators: [
                User(key: "c1", firstName: "User", lastName: "One", profileImageUrl: "http://upload.wikimedia.org/wikipedia/commons/9/9d/PalaceofFineArts1915.jpg"),
                User(key: "c2", firstName: "User", lastName: "Two", profileImageUrl: "http://upload.wikimedia.org/wikipedia/commons/9/9d/PalaceofFineArts1915.jpg"),
                User(key: "c3", firstName: "User", lastName: "Three", profileImageUrl: "http://upload.wikimedia.org/wikipedia/commons/9/9d/PalaceofFineArts1915.jpg")
            ],
            error: nil
        )*/
    }
    
    class func loadAll(completion: (stations: [Station]?, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.getStations(completion)
    }
}