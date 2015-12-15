//
//  GasStationViewController.swift
//  Voltage
//
//  Created by EVApp Team on 12/6/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit
import MapKit
import SystemConfiguration
import Foundation

class GasStationViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate{
    
    //----------------UI Links----------------
    @IBOutlet weak var gasStationMap: MKMapView!
    
    //-----------------------API-----------------------
    private var API = "http://api.mygasfeed.com/stations/radius"
    private let APIKey = "iz01eibvxt"
    
    //----------API Generated Arrays----------
    var location = [String]()  // Array of locations populated by API and displayed on the UI MapView
    
    
    //----------------Location Vars----------------
    var locationManager = CLLocationManager()
    var currentLocation = CLLocation()
    var locationArr = [CLLocation?]()
    
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
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        let latitude = userLocation.coordinate.latitude
        let longitude = userLocation.coordinate.longitude
        API = API + "/\(latitude)/\(longitude)/20/reg/price/iz01eibvxt.json"
        // Store users initial location-necessary for distance traveled
        if locationArr.count != 1 {
            self.locationArr.append(userLocation)
        }
        // Set zoom amount
        let latDelta: CLLocationDegrees = 0.01
        let lonDelta: CLLocationDegrees = 0.01
        // Create view variables and region of interest
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        // Center map at this region
        self.gasStationMap.setRegion(region, animated: true)
        
        // Enable map features
        self.gasStationMap.showsUserLocation = true;
        self.gasStationMap.showsScale = true;
        self.gasStationMap.showsPointsOfInterest = true;
        self.gasStationMap.showsTraffic = true;
        
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
                if let location = json["stations"] as? [[String: AnyObject]] {
                    for gasStations in location {
                        if let mapStationLat = gasStations["lat"] as? String {
                            self.location.append(mapStationLat)
                        }
                        if let mapStationLng = gasStations["lng"] as? String {
                            self.location.append(mapStationLng)
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
    
    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
        if (annotation is MKUserLocation) {
            //if annotation is not an MKPointAnnotation (eg. MKUserLocation),
            //return nil so map draws default view for it (eg. blue dot)...
            return nil
        }
        
        let reuseId = "test"
        
        var anView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
        if anView == nil {
            anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            anView!.image = UIImage(named:"xaxas")
            anView!.canShowCallout = true
        }
        else {
            //we are re-using a view, update its annotation reference...
            anView!.annotation = annotation
        }
        
        return anView
    }
}