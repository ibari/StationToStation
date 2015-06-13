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
    
    var station: Station?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Station"

        //headerView.image = UIImage(named: "yodawg")
        //headerView.nameLabel.text = "Testing"
        
        // add playlist subview
        configurePlaylist()
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
            playlistViewController.view.frame = self.containerView.frame
            self.containerView.addSubview(playlistViewController.view)
            playlistViewController.didMoveToParentViewController(self)
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
