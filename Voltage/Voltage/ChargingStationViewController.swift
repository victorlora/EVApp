//
//  ChargingStationViewController.swift
//  Voltage
//
//  Created by Josh Rosenzweig on 12/6/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class ChargingStationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var chargingStationMap: MKMapView!
    
    //-----------------------API-----------------------
    
    //----------------Location Vars----------------
    var locationManager = CLLocationManager()
    
    //--------------------------Functions--------------------------------
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        let refreshAlert = UIAlertController(title: "Memory Warning", message: "All data cannot be saved.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
    }
    

}