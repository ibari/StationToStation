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
    
    var delegate: RdioDelegate? {
        didSet {
            rdio.delegate = delegate
        }
    }
    
    init() {
        rdio = Rdio(clientId: self.rdioClientId, andSecret: self.rdioClientSecret, delegate: nil)
    }

    func authorizeFromController(vc: UIViewController) {
        rdio.authorizeFromController(vc)
    }
    
    func logout() {
        rdio.logout()
    }
    
    func searchTrack(query: String, completion: (tracks: [Track]?, error: NSError?) -> Void) {
        let param = ["dsads": "dsdsa"]
        
        rdio.callAPIMethod("search",
            withParameters: ["query": query, "types": "Track"],
            success: { (response) in
                var tracks = [Track]()
                if let results = response["results"] as? NSArray {
                    for rdioTrack in results {
                        let trackKey = rdioTrack["key"] as! String
                        let trackTitle = rdioTrack["name"] as! String
                        let artistName = rdioTrack["artist"] as! String
                        let albumImageUrl = rdioTrack["icon"] as! String
                        let duration = rdioTrack["duration"] as! Int
                        tracks.append(Track(key: trackKey, trackTitle: trackTitle, artistName: artistName, albumImageUrl: albumImageUrl, duration: duration))
                    }
                }
                completion(tracks: tracks, error: nil)
            }, failure: { (error) in
                completion(tracks: nil, error: error)
            }
        )
    }
    
    class var sharedInstance: RdioClient {
        struct Static {
            static let instance = RdioClient()
        }
        
        return Static.instance
    }
}
