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

        headerView.contentView.imageView.setImageWithURL(NSURL(string: station!.imageUrl))
        headerView.contentView.name = station!.name
        headerView.contentView.collaboratorsButton.addTarget(self, action: "didTapCollaboratorsButton", forControlEvents: UIControlEvents.TouchUpInside)

        setButtonAppearance()
        configurePlaylist()
    }
    
    func configurePlaylist() {
        self.station!.getPlaylist() { (playlist, error) in
            if let error = error {
                NSLog("Error loading playlist: \(error)")
                return
            }
            
            var storyboard = UIStoryboard(name: "Playlist", bundle: nil)
            self.playlistViewController = storyboard.instantiateViewControllerWithIdentifier("PlaylistViewController") as! PlaylistViewController
            self.playlistViewController.playlist = playlist!
            
            self.addChildViewController(self.playlistViewController)
            self.containerView.addSubview(self.playlistViewController.view)
            self.playlistViewController.didMoveToParentViewController(self)
        }
    }

    
    func didTapCollaboratorsButton() {
        /*self.station!.getCollaborators() { (collaborators, error) in
            if let error = error {
                NSLog("Error loading collaboratorlist: \(error)")
                return
            }

            var storyboard = UIStoryboard(name: "CollaboratorsView", bundle: nil)
            var collaboratorsViewController = storyboard.instantiateViewControllerWithIdentifier("CollaboratorsViewController") as! CollaboratorsViewController
            collaboratorsViewController.collaborators = collaborators
            self.navigationController!.pushViewController(collaboratorsViewController, animated: true)
        }*/
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
        station!.getPlaylist() { (playlist, error) in
            if let error = error {
                NSLog("Error loading playlist for track add: \(error)")
                return
            }
            
            playlist!.addTrack(track) { (playlist: Playlist?, error: NSError?) in
                if let error = error {
                    NSLog("Error adding track to playlist \(error)")
                    return
                }
                self.playlistViewController.playlist = playlist!
                self.playlistViewController.reloadData()
            }
        }
    }
}
