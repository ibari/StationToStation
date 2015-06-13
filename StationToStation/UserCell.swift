//
//  UserCell.swift
//  StationToStation
//
//  Created by Ian on 6/10/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class UserCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var usernameLabel: UILabel!
//    @IBOutlet weak var userCheckbox: Checkbox!
    
    var collaborator: Collaborator! {
        didSet {
        profileImageView.setImageWithURL(NSURL(string: collaborator.profileImageUrl))
            usernameLabel.text = collaborator.username
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
