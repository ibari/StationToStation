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

    // MARK: - Configuration
    
    func configureHeader() {
        headerView.contentView.imageView.setImageWithURL(NSURL(string: station!.imageUrl))
        headerView.contentView.name = station!.name
        
        headerView.contentView.trackCountLabel.text = String(station!.playlist!.tracks.count)
        headerView.contentView.collaboratorCountLabel.text = String(station!.collaborators!.count)
        headerView.contentView.commentCountLabel.text = String(station!.comments!.count)

        headerView.contentView.commentsButton.enabled = false
    }
}
