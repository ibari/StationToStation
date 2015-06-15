//
//  TrackCell.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/9/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class TrackCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var bumpCountLabel: UILabel!
    @IBOutlet weak var dropCountLabel: UILabel!
    @IBOutlet weak var bumpButton: UIButton!
    @IBOutlet weak var dropButton: UIButton!
    
    var track: Track! {
        didSet {
            iconImageView.setImageWithURL(NSURL(string: track.albumImageUrl))
            titleLabel.text = track.trackTitle
            artistLabel.text = track.artistName
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
