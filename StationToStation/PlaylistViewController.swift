//
//  PlaylistViewController.swift
//  StationToStation
//
//  Created by Ian on 6/8/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, TrackCellDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var station: Station!
    var playlist: Playlist!
    let trackSegueIdentifier = "trackSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 60
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.backgroundColor = UIColor.clearColor()
        tableView.reloadData()
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return playlist.tracks.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TrackCell", forIndexPath: indexPath) as! TrackCell
        
        cell.delegate = self
        cell.track = playlist.tracks[indexPath.item]
        
        if let collaborating = User.currentUser!.collaborating {
            if collaborating == false {
                cell.bumpButton.hidden = true
                cell.dropButton.hidden = true
            }
        }
        
        if indexPath.row == playlist.tracks.count - 1 {
            cell.separatorInset = UIEdgeInsetsMake(0, 10000, 0, 0)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == trackSegueIdentifier {
            if let indexPath = tableView.indexPathForSelectedRow() {
                let trackViewController = segue.destinationViewController as! TrackViewController
                
                trackViewController.station = station
                trackViewController.track = playlist.tracks[indexPath.row]
            }
        }
    }
    
    // MARK: - TrackCellDelegate
    
    func trackCell(sender: TrackCell, didChangeVote state: VoteState) {
        let track = sender.track
        
        playlist.setVoteForTrack(track.key, withState: state)
        
        RdioClient.sharedInstance.reorderPlaylist(playlist.key, tracks: playlist.tracks, withMeta: station.playlistMeta) { (playlist, error) -> Void in
            if let error = error {
                NSLog("Error while reordering playlist")
                return
            }
        }
        
        tableView.reloadData()
    }
}
