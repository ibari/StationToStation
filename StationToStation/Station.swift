//
//  Station.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/7/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class Station {
   
    let userKey: String
    let playlistKey: String
    let name: String
    let description: String
    let imageUrl: String
    
    init(userKey: String, playlistKey: String, name: String, description: String, imageUrl: String) {
        self.userKey = userKey
        self.playlistKey = playlistKey
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
    }
 
    func save(completion: (success: Bool, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.saveStation(self, completion: completion)
    }
    
    func getPlaylist(completion: (playlist: Playlist?, error: NSError?) -> Void) {
        completion(
            playlist: Playlist(userKey: userKey, playlistKey: playlistKey, tracks: [
                Track(trackKey: "t1", trackTitle: "Track 1", artistName: "Unknown", albumImageUrl: "http://upload.wikimedia.org/wikipedia/commons/9/9d/PalaceofFineArts1915.jpg"),
                Track(trackKey: "t2", trackTitle: "Track 2", artistName: "Unknown", albumImageUrl: "http://upload.wikimedia.org/wikipedia/commons/9/9d/PalaceofFineArts1915.jpg"),
                Track(trackKey: "t3", trackTitle: "Track 3", artistName: "Unknown", albumImageUrl: "http://upload.wikimedia.org/wikipedia/commons/9/9d/PalaceofFineArts1915.jpg"),
            ]),
            error: nil
        )
    }
    
    func inviteCollaborator(collaborator: People, completion: (success: Bool?, error: NSError?) -> Void) {
        completion(success: true, error: nil)
    }
    
    func getCollaborators(completion: (peoples: [People]?, error: NSError?) -> Void) {
        completion(
            peoples: [
                People(key: "p1", username: "User_1", profileImageUrl: "http://upload.wikimedia.org/wikipedia/commons/9/9d/PalaceofFineArts1915.jpg")
            ],
            error: nil
        )
    }
    
    class func loadAll(completion: (stations: [Station]?, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.getStations(completion)
    }
}