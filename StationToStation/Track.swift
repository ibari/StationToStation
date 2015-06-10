//
//  Track.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/7/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

class Track {

    let key: String
    let trackTitle: String
    let artistName: String
    let albumImageUrl: String
    
    init(key: String, trackTitle: String, artistName: String, albumImageUrl: String) {
        self.key = key
        self.trackTitle = trackTitle
        self.artistName = artistName
        self.albumImageUrl = albumImageUrl
    }
    
    class func search(phrase: String, completion: (tracks: [Track]?, error: NSError?) -> Void) {
        completion(
            tracks: [
                Track(key: "t11", trackTitle: "Search 1", artistName: "Unknown", albumImageUrl: "http://upload.wikimedia.org/wikipedia/commons/9/9d/PalaceofFineArts1915.jpg"),
                Track(key: "t12", trackTitle: "Search 2", artistName: "Unknown", albumImageUrl: "http://upload.wikimedia.org/wikipedia/commons/9/9d/PalaceofFineArts1915.jpg")
            ],
            error: nil
        )
    }
}
