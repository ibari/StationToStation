//
//  StationViewController.swift
//  StationToStation
//
//  Created by Ian on 6/10/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class StationViewController: UIViewController {
    
    @IBOutlet weak var headerView: StationHeaderView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var addTracksButton: UIButton!
    @IBOutlet weak var addPeopleButton: UIButton!
    
    var station: Station?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Station"

        headerView.contentView.imageView.setImageWithURL(station!.imageUrl)
        headerView.contentView.name = station!.name
        
        // need to select between configurePlaylist and configureCollaboratorslist depending on whether "Tracks" or "People" tab is clicked
        
        // configurePlaylist()
        configureCollaboratorslist()
    }
    
    func configurePlaylist() {
        self.station!.getPlaylist() { (playlist, error) in
            if let error = error {
                NSLog("Error loading playlist: \(error)")
                return
            }
            
            var storyboard = UIStoryboard(name: "Playlist", bundle: nil)
            var playlistViewController = storyboard.instantiateViewControllerWithIdentifier("PlaylistViewController") as! PlaylistViewController
            playlistViewController.playlist = playlist!
            
            self.addChildViewController(playlistViewController)
            self.containerView.addSubview(playlistViewController.view)
            playlistViewController.didMoveToParentViewController(self)
        }
    }

    
    func configureCollaboratorslist() {
        self.station!.getCollaborators() { (collaboratorlist, error) in
            if let error = error {
                NSLog("Error loading collaboratorlist: \(error)")
                return
            }
            
            
            var storyboard = UIStoryboard(name: "CollaboratorsView", bundle: nil)
            var collaboratorsViewController = storyboard.instantiateViewControllerWithIdentifier("CollaboratorsViewController") as! CollaboratorsViewController
            collaboratorsViewController.collaborators = collaboratorlist!
            
            self.addChildViewController(collaboratorsViewController)
            self.containerView.addSubview(collaboratorsViewController.view)
            collaboratorsViewController.didMoveToParentViewController(self)
            
            
        }
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func didTapAddTracks(sender: AnyObject) {
        var storyboard = UIStoryboard(name: "AddTracks", bundle: nil)
        var viewController = storyboard.instantiateViewControllerWithIdentifier("AddTracksViewController") as! AddTracksViewController
        self.navigationController!.pushViewController(viewController, animated: true)
    }

    @IBAction func didTapAddCollaborators(sender: AnyObject) {
        var storyboard = UIStoryboard(name: "Collaborators", bundle: nil)
        var viewController = storyboard.instantiateViewControllerWithIdentifier("AddCollaboratorsViewController") as! AddCollaboratorsViewController
        self.navigationController!.pushViewController(viewController, animated: true)
    }
    
    // MARK: - Testing
    
    @IBAction func didTapPlaylist(sender: AnyObject) {
        self.station!.getPlaylist() { (playlist, error) in
            if let error = error {
                NSLog("Error loading playlist: \(error)")
                return
            }
            
            var storyboard = UIStoryboard(name: "Playlist", bundle: nil)
            var playlistViewController = storyboard.instantiateViewControllerWithIdentifier("PlaylistViewController") as! PlaylistViewController
            playlistViewController.playlist = playlist!
            self.navigationController!.pushViewController(playlistViewController, animated: true)
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
