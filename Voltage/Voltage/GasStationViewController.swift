//
//  GasStationViewController.swift
//  Voltage
//
//  Created by Josh Rosenzweig on 12/6/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class GasStationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //-----------------------API-----------------------
    private let API = "http://api.mygasfeed.com/ "
    private let APIKey = "iz01eibvxt "
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        let refreshAlert = UIAlertController(title: "Memory Warning", message: "All data cannot be saved.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
    }
    
    
}