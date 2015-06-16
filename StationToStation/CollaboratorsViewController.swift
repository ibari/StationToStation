//
//  CollaboratorsViewController.swift
//  StationToStation
//
//  Created by Ian on 6/8/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class CollaboratorsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    // var station: Station?
    var collaborators: [User]!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "People"
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        tableView.reloadData()
        
        var sidebarBackgroundView = UIView(frame: CGRectZero)
        self.tableView.tableFooterView = sidebarBackgroundView
        self.tableView.backgroundColor = UIColor.clearColor()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return collaborators.count
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
