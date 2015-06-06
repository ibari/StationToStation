//
//  Utils.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/6/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit

class Utils {
    let secrets: NSDictionary
   
    init() {
        self.secrets = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("secrets", ofType: "plist")!)!
    }
    
    func getSecret(property: String) -> String {
        return secrets[property] as! String
    }
    
    class var sharedInstance: Utils {
        struct Static {
            static let instance = Utils()
        }
        return Static.instance
    }
}
