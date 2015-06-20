//
//  Utils.swift
//  StationToStation
//
//  Created by Benjamin Tsai on 6/6/15.
//  Copyright (c) 2015 Ian Bari. All rights reserved.
//

import UIKit
import Foundation

class Utils {
    let secrets: NSDictionary
   
    init() {
        self.secrets = NSDictionary(contentsOfFile: NSBundle.mainBundle().pathForResource("secrets", ofType: "plist")!)!
    }
    
    func getSecret(property: String) -> String {
        return secrets[property] as! String
    }
    
    func secondsToMinutes(interval: Double) -> String {
        let minutes = floor(interval / 60.0)
        let seconds = round(interval - minutes * 60.0)
        
        return "\(Int(minutes)):\(Int(seconds))"
    }
    
    func foo() {
        var dict = [String: String]()
        let data = NSJSONSerialization.dataWithJSONObject(dict, options: NSJSONWritingOptions.allZeros, error: nil)

    }
    
    class var sharedInstance: Utils {
        struct Static {
            static let instance = Utils()
        }
        return Static.instance
    }
}
