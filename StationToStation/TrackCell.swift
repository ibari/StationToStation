//
//  TrackCell.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/9/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var trackImageView: UIImageView!
    
    var track: Track! {
        didSet {
            titleLabel.text = track.trackTitle
            artistLabel.text = track.artistName
            trackImageView.setImageWithURL(NSURL(string: track.albumImageUrl))
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
