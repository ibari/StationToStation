//
//  TestViewController.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/9/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class TestViewController: UIViewController {

    @IBAction func onLogin(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Authentication", bundle: nil)
        let authVc = storyboard.instantiateViewControllerWithIdentifier("AuthenticationViewController") as! UIViewController
        
        presentViewController(authVc, animated: true, completion: nil)
    }
    
    @IBAction func doShowPlaylist(sender: AnyObject) {
        Station.loadAll() { (stations, error) in
            if let error = error {
                NSLog("Error loading stations: \(error)")
                return
            }
            
            stations![0].getPlaylist() { (playlist, error) in
                if let error = error {
                    NSLog("Error loading playlist: \(error)")
                    return
                }
                
                let storyboard = UIStoryboard(name: "Playlist", bundle: nil)
                let navVc = storyboard.instantiateInitialViewController() as! UINavigationController
                let playlistVc = navVc.topViewController as! PlaylistViewController
                
                playlistVc.playlist = playlist!
                
                self.presentViewController(navVc, animated: true, completion: nil)
            }
        }
    }

    @IBAction func doSearchTracks(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "SearchTrack", bundle: nil)
        let navVc = storyboard.instantiateInitialViewController() as! UINavigationController
        let playlistVc = navVc.topViewController as! SearchTrackViewController
        
        self.presentViewController(navVc, animated: true, completion: nil)
    }
}
