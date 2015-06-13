//
//  StationHeaderView.swift
//  StationToStation
//
//  Created by Ian on 6/11/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class StationHeaderView: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var image: UIImage? {
        get { return imageView.image }
        set { imageView.image = newValue }
    }
    
    var name: String? {
        get { return nameLabel.text }
        set { nameLabel.text = newValue }
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initSubviews()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initSubviews()
    }
    
    func initSubviews() {
        let nib = UINib(nibName: "StationHeaderView", bundle: nil)

        /*nib.instantiateWithOwner(self, options: nil)
        contentView.frame = bounds
        imageView.contentMode = UIViewContentMode.ScaleAspectFill
        imageView.clipsToBounds = true
        addSubview(contentView)*/
    }
}
