//
//  Station.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/7/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class Station: PlaylistMetaDelegate {
   
    var objectId: String?
    let ownerKey: String!
    let playlistKey: String!
    let name: String!
    let description: String!
    let imageUrl: String!
    let playlistMeta: PlaylistMeta!
    
    init(ownerKey: String, playlistKey: String, name: String, description: String, imageUrl: String, playlistMetaDict: [String: AnyObject]?) {
        self.ownerKey = ownerKey
        self.playlistKey = playlistKey
        self.name = name
        self.description = description
        self.imageUrl = imageUrl
        self.playlistMeta = PlaylistMeta(data: playlistMetaDict ?? [String: AnyObject]())

        playlistMeta.delegate = self
    }
 
    func save(completion: (success: Bool, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.saveStation(self, completion: completion)
    }
    
    func getPlaylist(completion: (playlist: Playlist?, error: NSError?) -> Void) {
        RdioClient.sharedInstance.getPlaylist(playlistKey, withMeta: playlistMeta, completion: { (playlist: Playlist?, error: NSError?) in
            if let error = error {
                completion(playlist: nil, error: error)
                return
            }

            completion(playlist: playlist, error: nil)
            return
        })
    }
    
    func getCollaborators(completion: (users: [User]?, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.getCollaborators(self, completion: completion)
    }
    
    class func loadAll(completion: (stations: [Station]?, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.getStations(completion)
    }
    
    // MARK: - PlaylistMetaDelegate
    
    func playlistMetaOnUpdate(sender: PlaylistMeta) {
        save { (success, error) -> Void in
            if let error = error {
                NSLog("Error while saving vote for station \(error)")
                return
            }
        }
    }
}

protocol PlaylistMetaDelegate {
    func playlistMetaOnUpdate(sender: PlaylistMeta)
}

class PlaylistMeta: PlaylistDelegate {
    
    var data: [String: AnyObject]
    var delegate: PlaylistMetaDelegate?
    
    init(data: [String: AnyObject]) {
        self.data = data
    }
    
    func apply(playlist: Playlist) {
        playlist.delegate = self
        
        let votes = getVotesForUser(User.currentUser!.key)
        for track in playlist.tracks {
            if let state = votes[track.key] {
                track.voteState = state
            }
        }
    }
    
    func setVoteForUser(key: String, forTrack trackKey: String, withState state: VoteState) {
        if data["votes"] == nil {
            data["votes"] = [String: [String: String]]()
        }
        
        var votes = data["votes"] as! [String: [String: String]]
        if votes[key] == nil {
            votes[key] = [String: String]()
        }
        
        if state == .Bump {
            votes[key]![trackKey] = "bump"
        } else if state == .Drop {
            votes[key]![trackKey] = "drop"
        } else {
            votes[key]![trackKey] = ""
        }
        
        data["votes"] = votes
        delegate?.playlistMetaOnUpdate(self)
    }
    
    func getVotesForUser(key: String) -> [String: VoteState] {
        let allVotes = (data["votes"] ?? [String: [String: String]]()) as! [String: [String: String]]
        let userVotes = allVotes[key] ?? [String: String]()
        
        var rtn = [String: VoteState]()
        for trackKeys in userVotes.keys {
            let trackVote = userVotes[trackKeys]
            if "bump" == trackVote {
                rtn[trackKeys] = VoteState.Bump
            } else  if "drop" == trackVote {
                rtn[trackKeys] = VoteState.Drop
            }
        }
        return rtn
    }
    
    func getData() -> [String: AnyObject] {
        return data
    }
    
    // MARK: - PlaylistDelegate
    
    func playlist(sender: Playlist, onSetVoteForTrack key: String, withState state: VoteState) {
        setVoteForUser(User.currentUser!.key, forTrack: key, withState: state)
    }
}

class Vote {
    let trackKey: String
    let state: VoteState
    
    init(trackKey: String, state: VoteState) {
        self.trackKey = trackKey
        self.state = state
    }
}

class TrackMeta {

}