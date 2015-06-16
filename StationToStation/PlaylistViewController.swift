//
//  PlaylistViewController.swift
//  StationToStation
//
//  Created by Ian on 6/8/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class PlaylistViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    var playlist: Playlist!
    let trackSegueIdentifier = "trackSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Track"
        
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
        
        cell.track = playlist.tracks[indexPath.item]
        
        if indexPath.row == 0 {
            cell.bumpButton.hidden = true
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
                trackViewController.track = playlist.tracks[indexPath.row]
            }
        }
    }
}
