//
//  InvitesViewController.swift
//  StationToStation
//
//  Created by Ian on 6/10/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class InvitesViewController: StationsViewController {
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.navigationItem.title = "Invites"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController!.navigationBar.translucent = false
        super.message = "You don't have any invites yet."
        
        loadStations()
    }
    
    override func loadStations() {
        DataStoreClient.sharedInstance.getInvitedStations { (stations, error) -> Void in
            if let error = error {
                NSLog("Error while fetching invited stations: \(error)")
                return
            }
            
            if let stations = stations {
                self.stations = stations
                self.collectionView.reloadData()
            } else {
                NSLog("Unexpected nil returned for invited stations")
                return
            }
        }
    }
}

