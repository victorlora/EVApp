//
//  MapViewContoller.swift
//  Voltage
//
//  Created by EVApp Team on 12/3/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    
    // UI Links
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var fuelEstLabel: UILabel!
    @IBOutlet var lowFuelIcon: UIImageView!
    
    // Location Vars
    var locationManager = CLLocationManager()
    var locationArr = [CLLocation?]()
    var startingLocation: CLLocation?
    var distanceTraveled: Double = 0
    var distanceTraveledOld: Double = 0
    var current = 0
    
    
    // Functions
    
    /* viewDidLoad()
    * @description
    *      Initial function call similar to main()
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Setup mapView
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    /* didReceiveMemoryWarning()
    * @description
    *      Used on large, memory intensive apps
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        let refreshAlert = UIAlertController(title: "Memory Warning",
            message: "All data cannot be saved.",
            preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default,
            handler: { (action: UIAlertAction!) in NSLog("OK was selected")
        }))
        
        dispatch_async(dispatch_get_main_queue(), {
            self.presentViewController(refreshAlert, animated: true, completion: nil)
        })
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let userLocation: CLLocation = locations[0]
        var refuelType = ""
        var energy = ""
        
        // Store users initial location - necessary for distance traveled
        if locationArr.count != 1 {
            self.locationArr.append(userLocation)
            self.startingLocation = self.locationArr.first!
        }
        
        //Check vehicle type for station search
        if (engType == "electric"){
            refuelType = "Electric"
            energy = "Electricity"
        } else if (engType == "hybrid"){
            refuelType = "Gas or Electric"
            energy = "Gas"
        } else if (engType == "gas"){
            refuelType = "Gas"
            energy = "Gas"
        } else if (engType == "diesel"){
            refuelType = "Diesel"
            energy = "Diesel"
        } else if (engType == "Flex-fuel-ffv"){
            refuelType = "Flex-Fuel"
            energy = "Gas"
        } else if (engType == "Natural-gas-cng"){
            refuelType = "CNG"
            energy = "CNG"
        }
        
        // Set distance traveled
        self.distanceTraveled = Double(userLocation.distanceFromLocation(self.startingLocation!))
            * 0.000621371
        
        // Check for user defaults for mileage estimate
        if (NSUserDefaults.standardUserDefaults().objectForKey("fuelEstimate") != nil) {
            // Update milesLeftEstimate
            milesLeftEstimate = milesLeftEstimate - (distanceTraveled - distanceTraveledOld)
            
            // save milesLeftEstimate to memory
            NSUserDefaults.standardUserDefaults().setObject(milesLeftEstimate, forKey: "fuelEstimate")
            fuelEstLabel.text = String(format: "%.0f", milesLeftEstimate) + " mi."
            
            // Handle when low fuel warning icon shows up
            if (milesLeftEstimate <= 20) {
                lowFuelIcon.hidden = false
            } else {
                lowFuelIcon.hidden = true
            }
            
            // Handle when fuel estimate goes negative
            if (milesLeftEstimate <= 0) {
                fuelEstLabel.text = "Fuel Level Critical!"
            }
            
            // Shows low gas alert at 20, 10, 5, and 1 by rounding the float: milesLeftEstimate
            if(round(milesLeftEstimate) == 20 || round(milesLeftEstimate) == 10
                || round(milesLeftEstimate) == 5 || round(milesLeftEstimate) == 1) {
                    
                    let lowMilesAlert = UIAlertController(title: "Warning Low \(energy)",
                        message: "Find The Nearest \(refuelType) Station",
                        preferredStyle: UIAlertControllerStyle.Alert)
                    
                    if (engType == "gas" || engType == "diesel"
                            || engType == "Natural-gas-cng" || engType == "Flex-fuel-ffv") {
                        lowMilesAlert.addAction(UIAlertAction(title: "Gas Stations",
                            style: .Default, handler: { (action: UIAlertAction!) in
                                self.performSegueWithIdentifier("GasStations", sender: self)
                        }))
                        lowMilesAlert.addAction(UIAlertAction(title: "OK",
                            style: .Default, handler: { (action: UIAlertAction!) in
                                NSLog("OK Pressed")
                        }))
                    }
                    else if(engType == "hybrid"){
                        lowMilesAlert.addAction(UIAlertAction(title: "Gas Stations",
                            style: .Default, handler: { (action: UIAlertAction!) in
                                self.performSegueWithIdentifier("GasStations", sender: self)
                        }))
                        lowMilesAlert.addAction(UIAlertAction(title: "OK",
                            style: .Default, handler: { (action: UIAlertAction!) in
                                NSLog("OK Pressed")
                        }))
                    }
                    else if(engType == "electric"){
                        lowMilesAlert.addAction(UIAlertAction(title: "Electric Stations",
                            style: .Default, handler: { (action: UIAlertAction!) in
                            self.performSegueWithIdentifier("ChargingStations", sender: self)
                        }))
                        lowMilesAlert.addAction(UIAlertAction(title: "OK", style: .Default,
                            handler: { (action: UIAlertAction!) in
                                NSLog("OK Pressed")
                        }))
                    }
                    if (self.current != Int(milesLeftEstimate)) {
                        dispatch_async(dispatch_get_main_queue(), {
                            self.presentViewController(lowMilesAlert, animated: true, completion: nil)
                        })
                    }
                    
                    self.current = Int(milesLeftEstimate)
            }
        } else {
            fuelEstLabel.text = "N/A"
        }
        
        // Display user's speed and distance traveled
        speedLabel.text = String(format: "%.0f", userLocation.speed * 2.23694)
        distanceLabel.text = String(format: "%.2f", self.distanceTraveled) + " mi."
        
        let latitude = userLocation.coordinate.latitude     // Set lat.
        let longitude = userLocation.coordinate.longitude   // Set lon.
        
        let latDelta: CLLocationDegrees = 0.01  // Set lat. zoom amount
        let lonDelta: CLLocationDegrees = 0.01  // Set lon. zoom amount
        
        // Create view variables and region of interest
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
        
        // Center map at this region
        self.mapView.setRegion(region, animated: true)
        
        // Enable map features
        self.mapView.showsUserLocation = true;
        self.mapView.showsScale = true;
        self.mapView.showsPointsOfInterest = true;
        self.mapView.showsTraffic = true;
        self.mapView.zoomEnabled = true;
        
        // Store old distance traveled
        self.distanceTraveledOld = self.distanceTraveled
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Stop updating location when user moves on to a different page
        // This may be something we want the user to run in the background...?
        locationManager.stopUpdatingLocation()
    }
}