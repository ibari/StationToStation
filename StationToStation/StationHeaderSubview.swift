//
//  StationHeaderSubview.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/13/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class StationHeaderSubview: UIView {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var trackCountLabel: UILabel!
    @IBOutlet weak var tracksLabel: UILabel!
    @IBOutlet weak var collaboratorCountLabel: UILabel!
    @IBOutlet weak var collaboratorsButton: UIButton!
    @IBOutlet weak var commentCountLabel: UILabel!
    @IBOutlet weak var commentsButton: UIButton!
    
    var name: String? {
        get { return nameLabel.text }
        set { nameLabel.text = newValue }
    }
    
    var trackCount: Int? {
        get {
            return trackCountLabel.text!.toInt()
        }
        set {
            trackCountLabel.text = "\(newValue!)"
            
            if newValue! == 1 {
                tracksLabel.text = "Track"
            }
        }
    }
    
    var collaboratorCount: Int? {
        get {
                return collaboratorCountLabel.text!.toInt()
            }
        set {
            collaboratorCountLabel.text = "\(newValue!)"
            
            if newValue! == 1 {
                collaboratorsButton.setTitle("Person", forState: UIControlState.Normal)
            }
        }
    }
    
    var commentCount: Int? {
        get {
            return commentCountLabel.text!.toInt()
        }
        set {
            commentCountLabel.text = "\(newValue!)"
            
            if newValue! == 1 {
                commentsButton.setTitle("Comment", forState: UIControlState.Normal)
            }
        }
    }
    
    @IBAction func onPlay(sender: AnyObject) {
        NSLog("onPlay")
    }
}
