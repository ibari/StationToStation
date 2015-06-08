//
//  Playlist.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/7/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class Playlist: NSObject {
   
    let userKey: String
    let playlistKey: String
    let tracks: [Track]
    
    init(userKey: String, playlistKey: String, tracks: [Track]) {
        self.userKey = userKey
        self.playlistKey = playlistKey
        self.tracks = tracks
    }
    
}
