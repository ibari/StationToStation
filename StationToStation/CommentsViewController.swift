//
//  CommentsViewController.swift
//  StationToStation
//
//  Created by Ian on 6/21/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var comments: [Comment]!

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 80
        
        tableView.tableFooterView = UIView(frame: CGRectZero)
        tableView.backgroundColor = UIColor.clearColor()
        
        tableView.reloadData()
    }
    
    func reloadData() {
        tableView.reloadData()
    }
    
    // MARK: - UITableViewDataSource

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell", forIndexPath: indexPath) as! CommentCell
        
        cell.comment = comments[indexPath.item]
        
        if indexPath.row == comments.count - 1 {
            cell.separatorInset = UIEdgeInsetsMake(0, 10000, 0, 0)
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
}
