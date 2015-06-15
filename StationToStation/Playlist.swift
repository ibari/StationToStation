//
//  Playlist.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/7/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class Playlist: NSObject {
   
    let key: String
    let ownerKey: String
    var tracks: [Track]
    
    init(key: String, ownerKey: String, tracks: [Track]) {
        self.key = key
        self.ownerKey = ownerKey
        self.tracks = tracks
    }
 
    func addTrack(track: Track, completion: (playlist: Playlist?, error: NSError?) -> Void) {
        RdioClient.sharedInstance.addTrackToPlaylist(key, trackKey: track.key, completion: completion)
    }
}