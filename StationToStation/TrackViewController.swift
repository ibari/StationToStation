//
//  TrackViewController.swift
//  StationToStation
//
//  Created by Ian on 6/14/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import Foundation
import UIKit

class TrackViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var albumImageUrl: UIImageView!
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var commentTextField: UITextField!
    @IBOutlet weak var bumpCountLabel: UILabel!
    @IBOutlet weak var dropCountLabel: UILabel!
    
    var station: Station!
    var track: Track!
    var comments: [Comment]?
    var commentsViewController: CommentsViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Track"
        
        albumImageUrl.setImageWithURL(NSURL(string: track!.albumImageUrl))
        trackTitle.text = track.trackTitle
        artistName.text = track.artistName
        durationLabel.text = Utils.sharedInstance.secondsToMinutes(Double(track.duration))
        
        bumpCountLabel.text = "\(track.bumps ?? 0) Bumps"
        dropCountLabel.text = "\(track.drops ?? 0) Drops"
        
        commentTextField.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name:UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name:UIKeyboardWillHideNotification, object: nil)
        
        var tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "DismissKeyboard")
        view.addGestureRecognizer(tap)
    
        loadComments()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y -= 260
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y += 260
    }
    
    func loadComments() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        DataStoreClient.sharedInstance.getTrackComments(track.key) { (comments, error) -> Void in
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
        commentsViewController.view.frame = containerView.bounds
        
        containerView.addSubview(commentsViewController.view)
        commentsViewController.didMoveToParentViewController(self)
    }
    
    // MARK: - Actions
    
    func DismissKeyboard() {
        view.endEditing(true)
    }
 
    // MARK: - UITextFieldDelegate
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        let comment = Comment(stationObjectId: station.objectId!, trackKey: track.key, userKey: User.currentUser!.key, text: self.commentTextField.text)
        
        comment.save() { (success, error) in
            if let error = error {
                NSLog("Error saving comment: \(error)")
                return
            }
            
            self.commentTextField.text = ""
            self.commentTextField.resignFirstResponder()
            self.loadComments()
            return
        }
        
        return true
    }
}
