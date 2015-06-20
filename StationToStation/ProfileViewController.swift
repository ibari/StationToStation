//
//  ProfileViewController.swift
//  StationToStation
//
//  Created by Ian on 6/20/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var user: User?
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.navigationItem.title = "Profile"
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        if user == nil {
            user = User.currentUser!
        }
        
        profileImageView.setImageWithURL(user!.profileImageUrl)
        nameLabel.text = "\(user!.firstName) \(user!.lastName)"
    }
}
