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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "People"
        
        self.configureHeader()
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 80
        
        self.tableView.tableFooterView = UIView(frame: CGRectZero)
        self.tableView.backgroundColor = UIColor.clearColor()
        
        self.tableView.reloadData()
    }
    
    // MARK: - Configuration
    
    func configureHeader() {
        headerView.contentView.imageView.setImageWithURL(NSURL(string: station!.imageUrl))
        headerView.contentView.name = station!.name
        
        headerView.contentView.trackCountLabel.text = String(station!.playlist!.tracks.count)
        headerView.contentView.collaboratorCountLabel.text = String(station!.collaborators!.count)
        
        headerView.contentView.collaboratorsButton.enabled = false
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return station!.collaborators!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("UserCell", forIndexPath: indexPath) as! UserCell
        
        cell.user = station!.collaborators![indexPath.row]
        
        if indexPath.row == station!.collaborators!.count - 1 {
            cell.separatorInset = UIEdgeInsetsMake(0, 10000, 0, 0)
        }

        return cell
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        var storyboard = UIStoryboard(name: "Profile", bundle: nil)
        var profileVC = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
        profileVC.user = station!.collaborators![indexPath.item]
        self.navigationController!.pushViewController(profileVC, animated: true)
    }
}
