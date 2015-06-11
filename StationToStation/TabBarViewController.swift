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
        
        // stations
        var stationsStoryboard = UIStoryboard(name: "Stations", bundle: nil)
        var stationsController = stationsStoryboard.instantiateInitialViewController() as! StationsViewController
        
        // invites
        var invitesStoryboard = UIStoryboard(name: "Invites", bundle: nil)
        var invitesController = invitesStoryboard.instantiateInitialViewController() as! InvitesViewController
        
        // profile
        var profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        var profileController = profileStoryboard.instantiateInitialViewController() as! ProfileViewController
        
        let controllers = [stationsController, invitesController, profileController]
        self.viewControllers = controllers
        
        self.selectedIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
