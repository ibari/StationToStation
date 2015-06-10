//
//  SearchTrackViewController.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/10/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class SearchTrackViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var tracks: [Track]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tracks = []

        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
    }
    
    func searchBarSearchButtonClicked(sender: UISearchBar) {
        Track.search(sender.text) { (tracks, error) in
            if let error = error {
                NSLog("Error while searching for track: \(error)")
                return
            }
            
            if let tracks = tracks {
                self.tracks = tracks
                self.tableView.reloadData()
            } else {
                NSLog("Unexpected nil returned for tracks")
                return
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tracks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let track = tracks[indexPath.item]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TrackCell", forIndexPath: indexPath) as! TrackCell
        cell.track = track
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let track = tracks[indexPath.item]
        
        NSLog("Should add track \(track.key) to playlist")
    }
}
