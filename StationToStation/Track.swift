//
//  Track.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/7/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

class Track {

    let trackKey: String
    let trackTitle: String
    let artistName: String
    let albumImageUrl: String
    
    init(trackKey: String, trackTitle: String, artistName: String, albumImageUrl: String) {
        self.trackKey = trackKey
        self.trackTitle = trackTitle
        self.artistName = artistName
        self.albumImageUrl = albumImageUrl
    }
    
    class func search(completion: (tracks: [Track]?, error: NSError?) -> Void) {
        completion(
            tracks: [
                Track(trackKey: "t11", trackTitle: "Search 1", artistName: "Unknown", albumImageUrl: "http://upload.wikimedia.org/wikipedia/commons/9/9d/PalaceofFineArts1915.jpg"),
                Track(trackKey: "t12", trackTitle: "Search 2", artistName: "Unknown", albumImageUrl: "http://upload.wikimedia.org/wikipedia/commons/9/9d/PalaceofFineArts1915.jpg")
            ],
            error: nil
        )
    }
}
