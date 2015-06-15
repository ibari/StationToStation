//
//  SearchTrackCell.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/9/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class SearchTrackCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var durationLabel: UILabel!
    
    var track: Track! {
        didSet {
            titleLabel.text = track.trackTitle
            artistLabel.text = track.artistName
            durationLabel.text = Utils.sharedInstance.secondsToMinutes(Double(track.duration))
            iconImageView.setImageWithURL(NSURL(string: track.albumImageUrl))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
