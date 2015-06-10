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
        
        // collaborators
        var collaboratorsStoryboard = UIStoryboard(name: "Collaborators", bundle: nil)
        var collaboratorsController = collaboratorsStoryboard.instantiateInitialViewController() as! CollaboratorsViewController
        
        // profile
        var profileStoryboard = UIStoryboard(name: "Profile", bundle: nil)
        var profileController = profileStoryboard.instantiateInitialViewController() as! ProfileViewController
        
        let controllers = [stationsController, collaboratorsController, profileController]
        self.viewControllers = controllers
        
        self.selectedIndex = 0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
