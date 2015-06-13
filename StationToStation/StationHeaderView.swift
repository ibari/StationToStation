//
//  StationHeaderView.swift
//  StationToStation
//
//  Created by Ian on 6/11/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class StationHeaderView: UIView {

    var contentView: StationHeaderSubview!
    
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
        addSubview(contentView)
    }
}
