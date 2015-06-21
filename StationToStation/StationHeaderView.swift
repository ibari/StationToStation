//
//  StationHeaderView.swift
//  StationToStation
//
//  Created by Ian on 6/11/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

protocol StationHeaderViewDelegate {
    func stationHeaderViewOnPlay(sender: StationHeaderView)
}

class StationHeaderView: UIView, StationHeaderSubviewDelegate {

    var contentView: StationHeaderSubview!
    var delegate: StationHeaderViewDelegate?
    
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
        contentView = nib.instantiateWithOwner(self, options: nil)[0] as! StationHeaderSubview
        contentView.delegate = self
        addSubview(contentView)
    }
    
    func stationHeaderSubviewOnPlay(sender: StationHeaderSubview) {
        delegate?.stationHeaderViewOnPlay(self)
    }
}
