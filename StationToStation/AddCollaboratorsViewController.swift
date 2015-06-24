//
//  AddCollaboratorsViewController.swift
//  StationToStation
//
//  Created by Ian on 6/10/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class AddCollaboratorsViewController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate, InviteUserCellDelegate {
        
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var station: Station?
    var collaborators: [User]!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collaborators = []
        
        searchBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.backgroundColor = UIColor.clearColor()
        
        tableView.reloadData()
    }
    
    // MARK: - Search Bar
    
    func searchBarSearchButtonClicked(sender: UISearchBar) {
        User.search(sender.text) { (user, error) in
            if let error = error {
                NSLog("Error while searching for user: \(error)")
                return
            }
            
            if let user = user {
                self.collaborators.append(user)
                self.tableView.reloadData()
            } else {
                NSLog("No user found")
                return
            }
        }
    }
    
    // MARK: - Table Views
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if collaborators != nil {
            return collaborators!.count
        } else {
            var messageLabel = UILabel(frame: CGRectMake(0, 50, self.view.bounds.size.width, 30))
            
            messageLabel.textColor = UIColor.lightGrayColor()
            messageLabel.textAlignment = NSTextAlignment.Center
            messageLabel.numberOfLines = 1
            messageLabel.text = "User not found"
            self.tableView.addSubview(messageLabel)
            
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("InviteUserCell", forIndexPath: indexPath) as! InviteUserCell
        cell.user = collaborators[indexPath.item]
        cell.delegate = self
        
        if indexPath.row == collaborators.count - 1 {
            cell.separatorInset = UIEdgeInsetsMake(0, 10000, 0, 0)
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    // MARK: - InviteUserCellDelegate
    
    func inviteUserCell(inviteUserCell: InviteUserCell, buttonTouched button: UIButton, didInviteUser userKey: String) {
        let invite = Invite(fromUserKey: User.currentUser!.key, toUserKey: userKey, stationObjectId: station!.objectId!, accepted: false)

        invite.save() { (success, error) in
            if let error = error {
                NSLog("Error while inviting user: \(error)")
                return
            }
            
            button.setTitle("Invited", forState: .Normal)
            button.enabled = false
            self.searchBar.text = ""
        }
    }
}
