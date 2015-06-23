//
//  StationCommentsViewController.swift
//  StationToStation
//
//  Created by Ian on 6/22/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class StationCommentsViewController: UIViewController {
    @IBOutlet weak var headerView: StationHeaderView!
    @IBOutlet weak var containerView: UIView!
    
    var station: Station!
    var comments: [Comment]?
    var commentsViewController: CommentsViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Comments"
        
        configureHeader()
        loadComments()
    }
    
    func loadComments() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        DataStoreClient.sharedInstance.getStationComments(station.objectId!) { (comments, error) -> Void in
            if let error = error {
                NSLog("Error while fetching comments: \(error)")
                return
            }
            
            if let comments = comments {
                self.comments = comments
                self.addCommentsView()
            } else {
                NSLog("Unexpected nil returned for comments")
                return
            }
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
    }
    
    func addCommentsView() {
        var storyboard = UIStoryboard(name: "Comments", bundle: nil)
        
        commentsViewController = storyboard.instantiateViewControllerWithIdentifier("CommentsViewController") as! CommentsViewController
        commentsViewController.comments = self.comments
        
        addChildViewController(commentsViewController)
        commentsViewController.view.frame = self.containerView.bounds
        
        self.containerView.addSubview(commentsViewController.view)
        commentsViewController.didMoveToParentViewController(self)
    }
    
    // MARK: - Actions
    
    func didTapCollaborators() {
        var storyboard = UIStoryboard(name: "Collaborators", bundle: nil)
        var collaboratorsVC = storyboard.instantiateViewControllerWithIdentifier("CollaboratorsViewController") as! CollaboratorsViewController
        
        collaboratorsVC.station = self.station!
        self.navigationController!.pushViewController(collaboratorsVC, animated: true)
    }

    // MARK: - Configuration
    
    func configureHeader() {
        headerView.contentView.imageView.setImageWithURL(NSURL(string: station!.imageUrl))
        headerView.contentView.name = station!.name
        
        headerView.contentView.trackCount = station!.playlist!.tracks.count
        headerView.contentView.collaboratorCount = station!.collaborators!.count
        headerView.contentView.commentCount = station!.comments!.count

        headerView.contentView.collaboratorsButton.addTarget(self, action: "didTapCollaborators", forControlEvents: UIControlEvents.TouchUpInside)
        headerView.contentView.commentsButton.enabled = false
    }
}
