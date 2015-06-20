//
//  Station.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/7/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class Station {
   
    var objectId: String?
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
    
    func getCollaborators(completion: (users: [User]?, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.getCollaborators(self, completion: completion)
    }
    
    class func loadAll(completion: (stations: [Station]?, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.getStations(completion)
    }
}