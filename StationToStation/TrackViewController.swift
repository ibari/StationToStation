//
//  TrackViewController.swift
//  StationToStation
//
//  Created by Ian on 6/14/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class TrackViewController: UIViewController {
    
    @IBOutlet weak var albumImageUrl: UIImageView!
    @IBOutlet weak var trackTitle: UILabel!
    @IBOutlet weak var artistName: UILabel!
    @IBOutlet weak var durationLabel: UILabel!
    @IBOutlet weak var userButton: UIButton!
    
    var track: Track!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        albumImageUrl.setImageWithURL(NSURL(string: track!.albumImageUrl))
        trackTitle.text = track.trackTitle
        artistName.text = track.artistName
        durationLabel.text = Utils.sharedInstance.secondsToMinutes(Double(track.duration))
    }
}
