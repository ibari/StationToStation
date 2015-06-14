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
    @IBOutlet weak var collaboratorsButton: UIButton!
    @IBOutlet weak var commentsButton: UIButton!
    
    var name: String? {
        get { return nameLabel.text }
        set { nameLabel.text = newValue }
    }
}
