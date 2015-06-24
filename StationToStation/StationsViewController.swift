//
//  StationsViewController.swift
//  StationToStation
//
//  Created by Ian on 6/8/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

private let reuseIdentifier = "StationCell"
private let sectionInsets = UIEdgeInsets(top: 12.0, left: 10.0, bottom: 10.0, right: 12.0)

class StationsViewController: UIViewController, CreateStationViewControllerDelegate {

    var collectionView: UICollectionView!
    var stations: [Station]?
    var message = "Join or create a station to get started."
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.navigationItem.title = "Stations"
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "loadStations", name: didUpdateCollaboration, object: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureNavigation()

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.registerNib(UINib(nibName: "StationCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.whiteColor()
        self.view = collectionView
        
        loadStations()
    }

    func loadStations() {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        
        DataStoreClient.sharedInstance.getAllStations { (stations, error) -> Void in
            if let error = error {
                NSLog("Error while fetching stations: \(error)")
                return
            }
            
            if let stations = stations {
                self.stations = stations
                self.collectionView.reloadData()
            } else {
                NSLog("Unexpected nil returned for stations")
                return
            }
            
            MBProgressHUD.hideHUDForView(self.view, animated: true)
        }
    }
    
    func showMessage(message: String) {
        var messageLabel = UILabel(frame: CGRectMake(0, 150, self.view.bounds.size.width, 30))
        
        messageLabel.textColor = UIColor.lightGrayColor()
        messageLabel.textAlignment = NSTextAlignment.Center
        messageLabel.numberOfLines = 1
        messageLabel.text = message
        self.view.addSubview(messageLabel)
    }
    
    func logout() {
        RdioClient.sharedInstance.logout()
    }
    
    func create() {
        var storyboard = UIStoryboard(name: "CreateStation", bundle: nil)
        var createStationVc = storyboard.instantiateViewControllerWithIdentifier("CreateStationViewController") as! CreateStationViewController
        createStationVc.delegate = self
        self.navigationController!.pushViewController(createStationVc, animated: true)
    }
    
    // MARK: - CreateStationViewControllerDelegate
    
    func createStationViewController(sender: CreateStationViewController, didCreateStation: Station) {
        // why doesn't popToViewController self work here?
        self.navigationController!.popViewControllerAnimated(true)
        loadStations()
    }
    
    // MARK: - Configuration
    
    func configureNavigation() {
        self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .Plain, target: self, action: "logout")
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .Plain, target: self, action: "create")
    }
}

// MARK: - UICollectionViewDataSource

extension StationsViewController: UICollectionViewDataSource {
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if stations != nil {
            return stations!.count
        } else {
            return 0
        }
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(reuseIdentifier, forIndexPath: indexPath) as! StationCell
        
        cell.station = stations![indexPath.item]
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        var storyboard = UIStoryboard(name: "Stations", bundle: nil)
        var stationVC = storyboard.instantiateViewControllerWithIdentifier("StationViewController") as! StationViewController
        stationVC.station = stations![indexPath.item]
        self.navigationController!.pushViewController(stationVC, animated: true)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension StationsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 170, height: 140)
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacing section: Int) -> CGFloat {
        return 10.0
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat {
        return 10.0
    }
}
