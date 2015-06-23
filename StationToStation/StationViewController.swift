//
//  StationViewController.swift
//  StationToStation
//
//  Created by Ian on 6/10/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class StationViewController: UIViewController, AddTracksViewControllerDelegate {
    
    @IBOutlet weak var headerView: StationHeaderView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var addTracksButton: UIButton!
    @IBOutlet weak var addPeopleButton: UIButton!
    
    var station: Station?
    var playlistViewController: PlaylistViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Station"
        
        User.currentUser!.collaborating(station!, completion: { (collaborating, error) -> Void in
            if let error = error {
                NSLog("Error calling isCollaborator: \(error)")
                return
            }
            
            User.currentUser!.collaborating = collaborating!
            self.configureNavigation()
        })
        
        configureHeader()
        addPlaylistView()
        setButtonAppearance()
    }
    
    func addPlaylistView() {
        var storyboard = UIStoryboard(name: "Playlist", bundle: nil)
        
        playlistViewController = storyboard.instantiateViewControllerWithIdentifier("PlaylistViewController") as! PlaylistViewController
        playlistViewController.station = station!
        playlistViewController.playlist = station!.playlist
        
        addChildViewController(playlistViewController)
        containerView.addSubview(playlistViewController.view)
        
        playlistViewController.view.frame = containerView.frame
        playlistViewController.view.center = playlistViewController.view.convertPoint(containerView.center, fromView: containerView)
        
        playlistViewController.didMoveToParentViewController(self)
    }
    
    // MARK: - Configuration
    
    func configureHeader() {
        headerView.contentView.imageView.setImageWithURL(NSURL(string: station!.imageUrl))
        headerView.contentView.name = station!.name
        
        headerView.contentView.trackCountLabel.text = String(station!.playlist!.tracks.count)
        
        headerView.contentView.collaboratorCountLabel.text = String(station!.collaborators!.count)
        headerView.contentView.collaboratorsButton.addTarget(self, action: "didTapCollaborators", forControlEvents: UIControlEvents.TouchUpInside)
        
        headerView.contentView.commentCountLabel.text = String(station!.comments!.count)
        headerView.contentView.commentsButton.addTarget(self, action: "didTapComments", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    func configureNavigation() {
        if station!.ownerKey != User.currentUser!.key {
            if let collaborating = User.currentUser!.collaborating {
                if collaborating {
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Leave", style: .Plain, target: self, action: "didTapLeave")
                } else {
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Join", style: .Plain, target: self, action: "didTapJoin")
                }
            }
        } else {
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Edit", style: .Plain, target: self, action: nil)
        }
    }
    
    func setButtonAppearance() {
        addTracksButton.backgroundColor = UIColor.clearColor()
        addTracksButton.layer.cornerRadius = 12
        addTracksButton.layer.borderWidth = 1
        addTracksButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        addTracksButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
        
        addPeopleButton.backgroundColor = UIColor.clearColor()
        addPeopleButton.layer.cornerRadius = 12
        addPeopleButton.layer.borderWidth = 1
        addPeopleButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        addPeopleButton.setTitleColor(UIColor.darkGrayColor(), forState: UIControlState.Normal)
    }
    
    // MARK: - Actions
    
    func didTapEdit() {
        // edit station form
    }
    
    func didTapJoin() {
        station!.collaborate(User.currentUser!, collaborating: true) { (success, error) -> Void in
            if let error = error {
                NSLog("Error joining station: \(error)")
                return
            }
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Leave", style: .Plain, target: self, action: "didTapLeave")
        }
    }
    
    func didTapLeave() {
        station!.collaborate(User.currentUser!, collaborating: false) { (success, error) -> Void in
            if let error = error {
                NSLog("Error leaving station: \(error)")
                return
            }
            
            self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Join", style: .Plain, target: self, action: "didTapJoin")
        }
    }
    
    func didTapCollaborators() {
        var storyboard = UIStoryboard(name: "Collaborators", bundle: nil)
        var collaboratorsVC = storyboard.instantiateViewControllerWithIdentifier("CollaboratorsViewController") as! CollaboratorsViewController
        
        collaboratorsVC.station = self.station!
        self.navigationController!.pushViewController(collaboratorsVC, animated: true)
    }
    
    func didTapComments() {
        var storyboard = UIStoryboard(name: "Comments", bundle: nil)
        var stationCommentsVC = storyboard.instantiateViewControllerWithIdentifier("StationCommentsViewController") as! StationCommentsViewController
        
          stationCommentsVC.station = self.station!
        self.navigationController!.pushViewController(stationCommentsVC, animated: true)
    }
    
    @IBAction func didTapAddTracks(sender: AnyObject) {
        var storyboard = UIStoryboard(name: "AddTracks", bundle: nil)
        var addTrackVC = storyboard.instantiateViewControllerWithIdentifier("AddTracksViewController") as! AddTracksViewController
        
        addTrackVC.delegate = self
        self.navigationController!.pushViewController(addTrackVC, animated: true)
    }

    @IBAction func didTapAddCollaborators(sender: AnyObject) {
        var storyboard = UIStoryboard(name: "Collaborators", bundle: nil)
        var addCollaboratorsVC = storyboard.instantiateViewControllerWithIdentifier("AddCollaboratorsViewController") as! AddCollaboratorsViewController
        
        addCollaboratorsVC.station = station
        self.navigationController!.pushViewController(addCollaboratorsVC, animated: true)
    }
    
    // MARK: - AddTracksViewControllerDelegate
    
    func addTracksViewController(sender: AddTracksViewController, didAddTrack track: Track) {
        self.navigationController!.popToViewController(self, animated: true)
        let playlist = station!.playlist
        
        playlist!.addTrack(track, withMeta: self.station!.playlistMeta) { (playlist: Playlist?, error: NSError?) in
            if let error = error {
                NSLog("Error adding track to playlist: \(error)")
                return
            }
            self.playlistViewController.playlist = playlist!
            self.playlistViewController.reloadData()
        }
    }
}
