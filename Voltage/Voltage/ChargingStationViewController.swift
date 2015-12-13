//
//  ChargingStationViewController.swift
//  Voltage
//
//  Created by Josh Rosenzweig on 12/6/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit
import MapKit
import SystemConfiguration
import Foundation

class ChargingStationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    //----------------UI Links----------------
    @IBOutlet weak var chargingStationMap: MKMapView!
    
    //-----------------------API-----------------------
    
    private let API = "http://api.openchargemap.io/v2/poi/?output=json&countrycode=US"
    
    //----------API Generated Arrays----------
    var locations = [String:String]()  // Array of latitude and longitude locations for charging stations
    
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
    
    func getLocations() {
        if isConnectedToNetwork() == true {
            // Setup the session to make REST GET call.
            let openChargeAPI: String = API
            let url = NSURL(string: openChargeAPI)!
            
            // Retreive JSON data
            let data = NSData(contentsOfURL: url)!
            
            // Read the JSON
            do {
                let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
                // Parse JSON
                if let location = json["latitude"] as? [[String: AnyObject]] {
                    for make in location {
                        if let _ = make["latitude"] as? String {
                        }
                    }
                }
                
            } catch {
                print("Error finding makes")
            }
        }
        else {
            print("Internet Not Available")
            let refreshAlert = UIAlertController(title: "No Internet Connection", message: "Retry When There is a Connection", preferredStyle: UIAlertControllerStyle.Alert)
            
            refreshAlert.addAction(UIAlertAction(title: "Retry", style: .Default, handler: { (action: UIAlertAction!) in
                
            }))
            dispatch_async(dispatch_get_main_queue(), {
                self.presentViewController(refreshAlert, animated: true, completion: nil)
            })
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        // Set zoom amount
        let latDelta: CLLocationDegrees = 0.01
        let lonDelta: CLLocationDegrees = 0.01
        // Create view variables and region of interest
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        // Center map at this region
        self.chargingStationMap.setRegion(region, animated: true)
        
        // Enable map features
        self.chargingStationMap.showsUserLocation = true
        self.chargingStationMap.showsScale = true
        self.chargingStationMap.showsPointsOfInterest = true
        self.chargingStationMap.showsTraffic = true
    }


}