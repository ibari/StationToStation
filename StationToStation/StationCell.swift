//
//  StationCell.swift
//  StationToStation
//
//  Created by Ian on 6/8/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class StationCell: UICollectionViewCell {

    @IBOutlet weak var banerImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var trackCountLabel: UILabel!
    
    var station: Station! {
        didSet {
            banerImageView.setImageWithURL(NSURL(string: station.imageUrl!))
            nameLabel.text = station!.name
            
            let tracks = station.playlist!.tracks.count
            trackCountLabel.text = (tracks == 1) ? "\(station.playlist!.tracks.count) Track" : "\(station.playlist!.tracks.count) Tracks"
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
