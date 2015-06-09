//
//  VoteViewController.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/6/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class VoteViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func onAddVote(sender: AnyObject) {
        
        let vote = Vote(userKey: "testUser", trackKey: "testTrack")
        vote.save { (success, error) in
            if let error = error {
                NSLog("Error saving \(error)")
            }
            
            NSLog("Vote save status: \(success)")
        }
        
    }
    
    @IBAction func onGetVotes(sender: AnyObject) {
        Vote.loadAll { (votes: [Vote]?, error: NSError?) in
            if let error = error {
                NSLog("Error: \(error)")
                return
            }
            
            NSLog("Received \(votes!.count) votes")
        }
    }
}
