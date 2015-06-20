//
//  RdioClient.swift
//  StationToStation
//
//  Created by Ian on 6/6/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class RdioClient {
    
    private var rdio: Rdio!
    private let rdioClientId = Utils.sharedInstance.getSecret("sts_client_id")
    private let rdioClientSecret = Utils.sharedInstance.getSecret("sts_client_secret")
    
    class var sharedInstance: RdioClient {
        struct Static {
            static let instance = RdioClient()
        }
        
        return Static.instance
    }
    
    var delegate: RdioDelegate? {
        didSet {
            rdio.delegate = delegate
        }
    }
    
    init() {
        rdio = Rdio(clientId: self.rdioClientId, andSecret: self.rdioClientSecret, delegate: nil)
    }
    
    // MARK: - User

    func authorizeFromController(vc: UIViewController) {
        rdio.authorizeFromController(vc)
    }
    
    func logout() {
        rdio.logout()
    }
    
    func searchUser(query: String, completion: (user: User?, error: NSError?) -> Void) {
        rdio.callAPIMethod("findUser",
            withParameters: [
                "email": query
            ], success: { (response) in
                var user = User(dictionary: response as NSDictionary)
                completion(user: user, error: nil)
            }, failure: { (error) in
                completion(user: nil, error: error)
            }
        )
    }
    
    func getUser(key: String, completion: (user: User?, error: NSError?) -> Void) {
        rdio.callAPIMethod("get",
            withParameters: [
                "keys": key
            ], success: { (response) in
                let user = self.rdioToUser(response as! [String : AnyObject])
                completion(user: user, error: nil)
            }, failure: { (error) in
                completion(user: nil, error: error)
            }
        )
    }

    func getUsers(keys: [String], completion: (users: [User]?, error: NSError?) -> Void) {
        rdio.callAPIMethod("get",
            withParameters: [
                "keys": ",".join(keys)
            ], success: { (response) in
                var users = [User]()
                
                for key in keys {
                    let rdioUser = response[key] as! [String : AnyObject]
                    users.append(self.rdioToUser(rdioUser))
                }
                
                completion(users: users, error: nil)
            }, failure: { (error) in
                completion(users: nil, error: error)
            }
        )
    }
    
    // MARK: - Playlist
    
    func createPlaylist(name: String, description: String, completion: (playlist: Playlist?, error: NSError?) -> Void) {
        rdio.callAPIMethod("createPlaylist",
            withParameters: [
                "name": name,
                "description": description,
                "tracks": "",
                "collaborationMode": 1,
                "extras": "tracks"
            ], success: { (response) in
                let playlist = self.rdioToPlaylist(response as! [String : AnyObject])
                completion(playlist: playlist, error: nil)
            }, failure: { (error) in
                completion(playlist: nil, error: error)
            }
        )
    }
    
    func getPlaylist(key: String, completion: (playlist: Playlist?, error: NSError?) -> Void) {
        rdio.callAPIMethod("get",
            withParameters: [
                "keys": key,
                "extras": "tracks"
            ], success: { (response) in
                let rdioPlaylist = response[key] as! [String : AnyObject]
                let playlist = self.rdioToPlaylist(rdioPlaylist)
                completion(playlist: playlist, error: nil)
            }, failure: { (error) in
                completion(playlist: nil, error: error)
            }
        )
    }
    
    func searchTrack(query: String, completion: (tracks: [Track]?, error: NSError?) -> Void) {
        rdio.callAPIMethod("search",
            withParameters: ["query": query, "types": "Track"],
            success: { (response) in
                var tracks = [Track]()
                if let results = response["results"] as? [[String : AnyObject]] {
                    for rdioTrack in results {
                        tracks.append(self.rdioToTrack(rdioTrack))
                    }
                }
                completion(tracks: tracks, error: nil)
            }, failure: { (error) in
                completion(tracks: nil, error: error)
            }
        )
    }
    
    func addTrackToPlaylist(key: String, trackKey: String, completion: (playlist: Playlist?, error: NSError?) -> Void) {
        rdio.callAPIMethod("addToPlaylist",
            withParameters: [
                "playlist": key,
                "tracks": trackKey,
                "extras": "tracks"
            ], success: { (response) in
                let playlist = self.rdioToPlaylist(response as! [String : AnyObject])
                completion(playlist: playlist, error: nil)
            }, failure: { (error) in
                completion(playlist: nil, error: error)
            }
        )
    }
    
    func rdioToUser(dict: [String : AnyObject]) -> User {
        return User(dictionary: dict as NSDictionary)
    }
    
    func rdioToPlaylist(dict: [String : AnyObject]) -> Playlist {
        let name = dict["name"] as! String
        let key = dict["key"] as! String
        let ownerKey = dict["ownerKey"] as! String
        
        let rdioTracks = dict["tracks"] as! [[String : AnyObject]]
        var tracks = [Track]()
        for rdioTrack in rdioTracks {
            tracks.append(rdioToTrack(rdioTrack))
        }
        
        return Playlist(key: key, ownerKey: ownerKey, tracks: tracks)
    }
    
    func rdioToTrack(dict: [String : AnyObject]) -> Track {
        let trackKey = dict["key"] as! String
        let trackTitle = dict["name"] as! String
        let artistName = dict["artist"] as! String
        let albumImageUrl = dict["icon"] as! String
        let duration = dict["duration"] as! Int
        return Track(key: trackKey, trackTitle: trackTitle, artistName: artistName, albumImageUrl: albumImageUrl, duration: duration)
    }
}
