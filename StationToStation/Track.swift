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
    let duration: Int

    var voteState: VoteState?
    var comments: [Comment]?
    
    init(key: String, trackTitle: String, artistName: String, albumImageUrl: String, duration: Int) {
        self.key = key
        self.trackTitle = trackTitle
        self.artistName = artistName
        self.albumImageUrl = albumImageUrl
        self.duration = duration
    }
    
    class func search(phrase: String, completion: (tracks: [Track]?, error: NSError?) -> Void) {
        RdioClient.sharedInstance.searchTrack(phrase, completion: completion)
    }
}
