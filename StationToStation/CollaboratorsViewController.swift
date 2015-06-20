//
//  CollaboratorsViewController.swift
//  StationToStation
//
//  Created by Ian on 6/8/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class CollaboratorsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var headerView: StationHeaderView!
    @IBOutlet weak var tableView: UITableView!
    
    var station: Station!
    var collaborators: [User]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "People"
        
        loadCollaborators()
    }
    
    func loadCollaborators() {
        station!.getCollaborators() { (users, error) in
            if let error = error {
                NSLog("Error loading collaboratorlist: \(error)")
                return
            }
            
            self.collaborators = users!
            self.configureHeader()
            
            self.tableView.delegate = self
            self.tableView.dataSource = self
            
            self.tableView.rowHeight = UITableViewAutomaticDimension
            self.tableView.estimatedRowHeight = 80
            
            self.tableView.tableFooterView = UIView(frame: CGRectZero)
            self.tableView.backgroundColor = UIColor.clearColor()
            
            self.tableView.reloadData()
        }
    }
    
    // MARK: - Configuration
    
    func configureHeader() {
        headerView.contentView.imageView.setImageWithURL(NSURL(string: station!.imageUrl))
        headerView.contentView.name = station!.name
        headerView.contentView.collaboratorCountLabel.text = String(collaborators!.count)
        headerView.contentView.collaboratorsButton.enabled = false
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collaborators!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
        
        cell.user = collaborators![indexPath.row]

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
