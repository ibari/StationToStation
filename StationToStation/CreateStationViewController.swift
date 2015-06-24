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

class CreateStationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var createButton: UIButton!
    
    var delegate: CreateStationViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonAppearance()
    }
    
    // MARK: - Configuration
    
    func setButtonAppearance() {
        createButton.backgroundColor = UIColor.clearColor()
        createButton.layer.cornerRadius = 12
        createButton.layer.borderWidth = 1
        createButton.layer.borderColor = UIColor(red: 0.0/255.0, green: 142.0/255.0, blue: 212.0/255.0, alpha: 1.0).CGColor
    }
    
    // MARK: - Actions
    
    @IBAction func didTapImageButton(sender: AnyObject) {
        var vc = UIImagePickerController()
        
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }

    @IBAction func createButton(sender: AnyObject) {
        let ownerKey = User.currentUser!.key
        let name = nameTextField.text
        let description = descriptionTextField.text
        
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)

        RdioClient.sharedInstance.createPlaylist(name, description: description) { (playlist: Playlist?, error: NSError?) in
            if let error = error {
                NSLog("Error while creating playlist \(error)")
                return
            }
  
            let playlistKey = playlist!.key
            let station = Station(ownerKey: ownerKey, playlistKey: playlistKey, name: name, description: description, image: self.headerImageView.image!, playlistMetaDict: nil)
            
            station.save() { (success, error) in
                if let error = error {
                    NSLog("Error while creating station \(error)")
                    return
                }

                DataStoreClient.sharedInstance.saveCollaborator(User.currentUser!, station: station, completion: { (success, error) -> Void in
                    if let error = error {
                        NSLog("Error while saving owner as initial collaborator on the station \(error)")
                        return
                    }
                    
                    MBProgressHUD.hideHUDForView(self.view, animated: true)
                    self.delegate?.createStationViewController(self, didCreateStation: station)
                })
            }
        }
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        var image = info[UIImagePickerControllerOriginalImage] as! UIImage
        
        headerImageView.image = image
        dismissViewControllerAnimated(true, completion: nil)
    }
}
