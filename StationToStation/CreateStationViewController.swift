//
//  CreateStationViewController.swift
//  StationToStation
//
//  Created by Ian on 6/12/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

protocol CreateStationViewControllerDelegate {
    func createStationViewController(sender: CreateStationViewController, didCreateStation: Station)
}

class CreateStationViewController: UIViewController {

    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    var delegate: CreateStationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createButton.backgroundColor = UIColor.clearColor()
        createButton.layer.cornerRadius = 12
        createButton.layer.borderWidth = 1
        createButton.layer.borderColor = UIColor(red: 0.0/255.0, green: 142.0/255.0, blue: 212.0/255.0, alpha: 1.0).CGColor
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func createButton(sender: AnyObject) {
        let ownerKey = User.currentUser!.key
        let name = nameTextField.text
        let description = descriptionTextField.text

        RdioClient.sharedInstance.createPlaylist(name, description: description) { (playlist: Playlist?, error: NSError?) in
            if let error = error {
                NSLog("Error while creating playlist \(error)")
                return
            }
  
            let playlistKey = playlist!.key
            let imageUrl = "http://rdiodynimages3-a.akamaihd.net/?l=album/browse/rectangle/Top_Stations.jpg"
            
            let station = Station(ownerKey: ownerKey, playlistKey: playlistKey, name: name, description: description, imageUrl: imageUrl)
            station.save() { (success, error) in
                if let error = error {
                    NSLog("Error while creating station \(error)")
                    return
                }

                self.delegate?.createStationViewController(self, didCreateStation: station)
            }
        }
    }
}
