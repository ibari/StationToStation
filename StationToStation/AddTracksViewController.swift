//
//  AddTracksViewController.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/10/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

protocol AddTracksViewControllerDelegate {
    func addTracksViewController(sender: AddTracksViewController, didAddTrack: Track)
}

class AddTracksViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    var tracks: [Track]!

    var delegate: AddTracksViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tracks = []

        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.reloadData()
        
        var sidebarBackgroundView = UIView(frame: CGRectZero)
        self.tableView.tableFooterView = sidebarBackgroundView
        self.tableView.backgroundColor = UIColor.clearColor()
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
        
        let cell = tableView.dequeueReusableCellWithIdentifier("SearchTrackCell", forIndexPath: indexPath) as! SearchTrackCell
        cell.track = track
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let track = tracks[indexPath.item]
        
        delegate?.addTracksViewController(self, didAddTrack: track)
    }
}
