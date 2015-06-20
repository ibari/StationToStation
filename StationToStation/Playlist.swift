//
//  Playlist.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/7/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

protocol PlaylistDelegate {
    func playlist(sender: Playlist, onSetVoteForTrack key: String, withState state: VoteState)
}

class Playlist: NSObject {
   
    let key: String
    let ownerKey: String
    var tracks: [Track]
    
    var delegate: PlaylistDelegate?
    
    init(key: String, ownerKey: String, tracks: [Track]) {
        self.key = key
        self.ownerKey = ownerKey
        self.tracks = tracks
    }
 
    func addTrack(track: Track, withMeta meta: PlaylistMeta, completion: (playlist: Playlist?, error: NSError?) -> Void) {
        RdioClient.sharedInstance.addTrackToPlaylist(key, trackKey: track.key, withMeta: meta, completion: completion)
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

            var delta = 0
            switch state {
            case .Bump:
                delta = -1
                track.voteState = .Bump
                delegate?.playlist(self, onSetVoteForTrack: track.key, withState: track.voteState!)
            case .Drop:
                delta = 1
                track.voteState = .Drop
                delegate?.playlist(self, onSetVoteForTrack: track.key, withState: track.voteState!)
            case .Neutral:
                // buggy .. bump top and bump second to top has same unbump behavior
                let oldState = track.voteState ?? .Neutral
                switch oldState {
                case .Bump:
                    delta = 1
                case .Drop:
                    delta = -1
                case .Neutral:
                    delta = 0
                }
                track.voteState = .Neutral
                delegate?.playlist(self, onSetVoteForTrack: track.key, withState: track.voteState!)
            }
            
            if trackIndex + delta >= 0 && trackIndex + delta <= tracks.count - 1 {
                tracks.removeAtIndex(trackIndex)
                tracks.insert(track, atIndex: trackIndex + delta)
            }
        }
    }
}