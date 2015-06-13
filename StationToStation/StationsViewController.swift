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

class StationsViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var stations: [Station]?
    let stationSegueIdentifier = "stationSegue"
    
    override func viewWillAppear(animated: Bool) {
        self.tabBarController?.navigationItem.title = "Stations"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureToolbar()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        DataStoreClient.sharedInstance.getStations { (stations, error) -> Void in
            self.stations = stations
            self.collectionView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Configuration
    
    func configureToolbar() {
        self.tabBarController?.navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Sign Out", style: .Plain, target: self, action: "logout")
        
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Create", style: .Plain, target: self, action: "create")
    }
    
    func logout() {
        RdioClient.sharedInstance.logout()
    }
    
    func create() {
        var storyboard = UIStoryboard(name: "CreateStation", bundle: nil)
        var createStationViewController = storyboard.instantiateViewControllerWithIdentifier("CreateStationViewController") as! CreateStationViewController
        self.navigationController!.pushViewController(createStationViewController, animated: true)
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == stationSegueIdentifier {
            if let indexPath = collectionView.indexPathForCell((sender as? StationCell)!) {
                let stationViewController = segue.destinationViewController as! StationViewController
                stationViewController.station = stations![indexPath.row]
            }
        }
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
        
        cell.station = stations![indexPath.row]
        
        return cell
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
