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
                Track(key: "t1", trackTitle: "No Fun", artistName: "Stooges", albumImageUrl: "http://rdio3img-a.akamaihd.net/album/a/2/3/000000000007232a/square-1200.jpg"),
                Track(key: "t2", trackTitle: "Five Years", artistName: "David Bowie", albumImageUrl: "http://rdio3img-a.akamaihd.net/album/c/e/f/0000000000352fec/2/square-1200.jpg"),
                Track(key: "t3", trackTitle: "Hiding In My Car", artistName: "Sector Zero", albumImageUrl: "http://rdio3img-a.akamaihd.net/album/8/9/d/000000000050ad98/2/square-1200.jpg")
            ],
            error: nil
        )
    }
}
