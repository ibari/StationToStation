//
//  Checkbox.swift
//  StationToStation
//
//  Created by Steve Wan on 6/12/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class Checkbox: UIButton {

    let checkedImage = UIImage(named: "Very Basic Checked checkbox")
    let uncheckedImage = UIImage(named: "Very Basic Unchecked checkbox")
    
    
    
    var isChecked:Bool = false{
        didSet{
            if isChecked == true{
                self.setImage(checkedImage, forState: .Normal)
            }
            else {
                self.setImage(uncheckedImage, forState: .Normal)
            }
        }
        
    }// isChecked
    
    
    override func awakeFromNib() {
        self.addTarget(self, action: "buttondClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        self.isChecked = false
    }
    
    func buttondClicked(sender:UIButton) {
        if(sender == self) {
            if isChecked == true{
                isChecked = false
            }
            else {
                isChecked = true
            }
        }// sender
    } // buttondClicked
}
