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
    
    var station: Station?
    var collaborators: [Collaborator]!
    var InvitedCollaborators: [Collaborator] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collaborators = []
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 120
        tableView.reloadData()
        
        var sidebarBackgroundView = UIView(frame: CGRectZero)
        self.tableView.tableFooterView = sidebarBackgroundView
        self.tableView.backgroundColor = UIColor.clearColor()
        
        // tableView.setEditing(true, animated: true)
        tableView.allowsMultipleSelection = true
        

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
    
    /*
    func updateCount(){
        if tableView.UserCell.userCheckBox == true {
            
        }
        if let list = tableView.indexPathsForSelectedRows() as? [NSIndexPath] {
            println(list.count)
        }
    }
    */

    @IBAction func onAddButtonClicked(sender: AnyObject) {
        // need to store the table into an array first?
        // go through each row selected and pack into an array to be the invitees
        
        println("INVITED collaborators are \(InvitedCollaborators)")
        
        
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let collaborator = collaborators[indexPath.item]
        var cell:UITableViewCell = tableView.cellForRowAtIndexPath(indexPath)!
        
        println("Row Selected")
       
        
        switch cell.accessoryType {
        case .None:
                cell.accessoryType = .Checkmark
                InvitedCollaborators.append(collaborator)
        default:
                cell.accessoryType = .None
                // need to remove collaborator from the InvitedCollaborators list

        }
        
        tableView.reloadData()


        // NSLog("Should add user \(collaborator.key) to invitees")
    }
 
    
    

}
