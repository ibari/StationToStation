//
//  AddCollaboratorsViewController.swift
//  StationToStation
//
//  Created by Ian on 6/10/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class AddCollaboratorsViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {
        
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var collaborators: [Collaborator]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collaborators = []
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
    }
    
    func searchBarSearchButtonClicked(sender: UISearchBar) {
        Collaborator.search(sender.text) { (collaborators, error) in
            if let error = error {
                NSLog("Error while searching for collaborator: \(error)")
                return
            }
            
            if let collaborators = collaborators {
                self.collaborators = collaborators
                self.tableView.reloadData()
            } else {
                NSLog("Unexpected nil returned for collaborators")
                return
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collaborators.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let collaborator = collaborators[indexPath.item]
        
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
        cell.collaborator = collaborator
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let collaborator = collaborators[indexPath.item]
        
        NSLog("Should add user \(collaborator.key) to collaborators")
    }
}
