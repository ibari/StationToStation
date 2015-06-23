//
//  TabBarViewController.swift
//  StationToStation
//
//  Created by Ian on 6/10/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        var stationsController = StationsViewController()
        var invitesController = InvitesViewController()
        var profileController = ProfileViewController()

        self.viewControllers = [stationsController, invitesController, profileController]
        self.selectedIndex = 0
        
        stationsController.tabBarItem = UITabBarItem(title: "Stations", image: UIImage(named: "radio-waves"), tag: 0)
        invitesController.tabBarItem = UITabBarItem(title: "Invites", image: UIImage(named: "envelope"), tag: 1)
        profileController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(named: "profile"), tag: 2)
    }
}
