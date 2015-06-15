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

    var delegate: CreateStationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func createButton(sender: AnyObject) {
        let ownerKey = User.currentUser!.key
        let name = nameTextField.text
        let description = descriptionTextField.text

        RdioClient.sharedInstance.createPlaylist("aaa", description: "bbb") { (playlist: Playlist?, error: NSError?) in
            if let error = error {
                NSLog("Error while creating playlist \(error)")
                return
            }
  
            let playlistKey = playlist!.key
            let imageUrl = "http://rdiodynimages3-a.akamaihd.net/?l=album/browse/rectangle/Classics.jpg"
            
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
