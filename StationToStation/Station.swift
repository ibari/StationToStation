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
    var imageUrl = "http://rdiodynimages3-a.akamaihd.net/?l=album/browse/rectangle/Top_Stations.jpg"
    var image: UIImage?
    let playlistMeta: PlaylistMeta!

    var collaborators: [User]?
    var playlist: Playlist?
    var comments: [Comment]?
    
    init(ownerKey: String, playlistKey: String, name: String, description: String, image: UIImage?, playlistMetaDict: [String: AnyObject]?) {
        self.ownerKey = ownerKey
        self.playlistKey = playlistKey
        self.name = name
        self.description = description
        self.image = image
        self.playlistMeta = PlaylistMeta(data: playlistMetaDict ?? [String: AnyObject]())

        playlistMeta.delegate = self
    }
 
    func save(completion: (success: Bool, error: NSError?) -> Void) {
        DataStoreClient.sharedInstance.saveStation(self, completion: completion)
    }
    
    func collaborate(user: User, collaborating: Bool, completion: (success: Bool, error: NSError?) -> Void) {
        RdioClient.sharedInstance.stationCollaborate(self, user: user, collaborating: collaborating, completion: completion)
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
        
        let myVotes = getVotesForUser(User.currentUser!.key)
        let allVotesByTrack = getVotesByTrack()
        
        for track in playlist.tracks {
            if let state = myVotes[track.key] {
                track.voteState = state
            }
            
            if allVotesByTrack[track.key] == nil {
                track.bumps = 0
                track.drops = 0
            } else {
                let trackVotes = allVotesByTrack[track.key]!
                var bumpCount = 0
                var dropCount = 0
                for vote in trackVotes {
                    if vote == .Bump {
                        bumpCount += 1
                    } else if vote == .Drop {
                        dropCount += 1
                    }
                }
                track.bumps = bumpCount
                track.drops = dropCount
            }
        }
    }
    
    // User : Track : Vote
    func getVotes() -> [String: [String: String]] {
        if data["votes"] == nil {
            data["votes"] = [String: [String: String]]()
        }
        
        var votes = data["votes"] as! [String: [String: String]]
        return votes
    }
    
    func setVoteForUser(key: String, forTrack trackKey: String, withState state: VoteState) {
        var votes = getVotes()
        
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
        let allVotes = getVotes()
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
    
    func getVotesByTrack() -> [String : [VoteState]] {
        let votes = getVotes()
        
        var votesByTrack = [String : [VoteState]]()
        
        for userKey in votes.keys {
            let userVotes = votes[userKey]!
            for trackKey in userVotes.keys {
                let stateStr = userVotes[trackKey]!
                
                let state: VoteState
                if stateStr == "bump" {
                    state = .Bump
                } else if stateStr == "drop" {
                    state = .Drop
                } else {
                    state = .Neutral
                }
                
                if votesByTrack[trackKey] == nil {
                    votesByTrack[trackKey] = [VoteState]()
                }
                votesByTrack[trackKey]!.append(state)
            }
        }
        
        return votesByTrack
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