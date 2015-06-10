//
//  StationCell.swift
//  StationToStation
//
//  Created by Ian on 6/8/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class StationCell: UICollectionViewCell {

    @IBOutlet weak var stationButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var trackCountLabel: UILabel!
    
    var station: Station! {
        didSet {
            stationButton.setImageForState(UIControlState.Normal, withURL: station.imageUrl!)
            nameLabel.text = station!.name
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
