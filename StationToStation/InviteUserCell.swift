//
//  InviteUserCell.swift
//  StationToStation
//
//  Created by Ian on 6/10/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

@objc protocol InviteUserCellDelegate {
    optional func inviteUserCell(inviteUserCell: InviteUserCell, buttonTouched button: UIButton, didInviteUser userKey: String)
}

class InviteUserCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var inviteButton: UIButton!
    
    var user: User! {
        didSet {
            profileImageView.setImageWithURL(user.profileImageUrl)
            nameLabel.text = "\(user.firstName) \(user.lastName)"
        }
    }
    
    weak var delegate: InviteUserCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        profileImageView.layer.masksToBounds = false
        profileImageView.layer.cornerRadius = profileImageView.frame.height / 2
        profileImageView.clipsToBounds = true
        
        inviteButton.backgroundColor = UIColor.clearColor()
        inviteButton.layer.cornerRadius = 12
        inviteButton.layer.borderWidth = 1
        inviteButton.layer.borderColor = UIColor(red: 0.0/255.0, green: 142.0/255.0, blue: 212.0/255.0, alpha: 1.0).CGColor
        
        inviteButton.addTarget(self, action: "didTapInvite:", forControlEvents: UIControlEvents.TouchUpInside)
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func didTapInvite(sender: UIButton) {
        delegate?.inviteUserCell?(self, buttonTouched: inviteButton, didInviteUser: user.key)
    }
}
