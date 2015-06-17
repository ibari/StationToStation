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
    
    func setVoteForTrack(key: String, withState state: VoteState) {
        var trackIndex: Int?
        for i in 0..<tracks.count {
            if tracks[i].key == key {
                trackIndex = i
                break
            }
        }
        if let trackIndex = trackIndex {
            let track = tracks[trackIndex]
            
            switch state {
            case .Bump:
                if trackIndex > 0 && track.voteState != .Bump {
                    tracks.removeAtIndex(trackIndex)
                    tracks.insert(track, atIndex: trackIndex - 1)
                    track.voteState = .Bump
                }
            case .Drop:
                if trackIndex < tracks.count - 1 && track.voteState != .Drop {
                    tracks.removeAtIndex(trackIndex)
                    tracks.insert(track, atIndex: trackIndex + 1)
                    track.voteState = .Drop
                }
            case .Neutral:
                track.voteState = .Neutral
            }
        }
    }
}