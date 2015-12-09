//
//  GasStationViewController.swift
//  Voltage
//
//  Created by Josh Rosenzweig on 12/6/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit
import MapKit
import SystemConfiguration
import Foundation

class GasStationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    @IBOutlet weak var gasStationMap: MKMapView!
    //-----------------------API-----------------------
    private let API = "http://api.mygasfeed.com/"
    private let APIKey = "iz01eibvxt "
    
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
    
    /* isConnectedToNetwork()
    * @description
    *      Checks for network connection
    */
    
    func isConnectedToNetwork() -> Bool {
        
        var blankAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0, sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
        blankAddress.sin_len = UInt8(sizeofValue(blankAddress))
        blankAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(&blankAddress) {
            SCNetworkReachabilityCreateWithAddress(kCFAllocatorDefault, UnsafePointer($0))
        }
        
        var stop: SCNetworkReachabilityFlags = SCNetworkReachabilityFlags(rawValue: 0)
        if SCNetworkReachabilityGetFlags(defaultRouteReachability!, &stop) == false {
            return false
        }
        
        let Reachable = stop == .Reachable
        let requiresConnection = stop == .ConnectionRequired
        
        return Reachable && !requiresConnection
        
    }
    
}