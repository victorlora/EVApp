//
//  MapViewContoller.swift
//  Voltage
//
//  Created by Josh Rosenzweig on 12/3/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit
import MapKit
import Foundation

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet var speedLabel: UILabel!
    @IBOutlet var distanceLabel: UILabel!
    @IBOutlet var fuelEstLabel: UILabel!
    
    var locationManager = CLLocationManager()
    var locationArr = [CLLocation?]()
    var startingLocation: CLLocation?
    var distanceTraveled: Double = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        let refreshAlert = UIAlertController(title: "Memory Warning", message: "All data cannot be saved.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        //print(locations)
        let userLocation: CLLocation = locations[0]
        if locationArr.count != 1 {
            self.locationArr.append(userLocation)
            self.startingLocation = self.locationArr.first!
        }
        
        self.distanceTraveled = Double(userLocation.distanceFromLocation(self.startingLocation!)) * 0.000621371
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("fuelEstimate") != nil) {
            fuelEstimate = fuelEstimate - (distanceTraveled / Double(combinedMPG))
            print(fuelEstimate)
            NSUserDefaults.standardUserDefaults().setObject(fuelEstimate, forKey: "fuelEstimate")
            fuelEstLabel.text = String(format: "%.0f", fuelEstimate) + " mi."
        } else {
            fuelEstLabel.text = "N/A"
        }
        let latitude = userLocation.coordinate.latitude

        let longitude = userLocation.coordinate.longitude
        
        let latDelta: CLLocationDegrees = 0.01
        let lonDelta: CLLocationDegrees = 0.01
        
        let span: MKCoordinateSpan = MKCoordinateSpanMake(latDelta, lonDelta)
        
        let location: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        
        let region: MKCoordinateRegion = MKCoordinateRegionMake(location, span)
       
        // center map at this region
        self.mapView.setRegion(region, animated: true)
        
        self.mapView.showsUserLocation = true;
        self.mapView.showsScale = true;
        self.mapView.showsPointsOfInterest = true;
        self.mapView.showsTraffic = true;
        
        // print user speed
        speedLabel.text = String(format: "%.0f", userLocation.speed * 2.23694)
        distanceLabel.text = String(format: "%.2f", self.distanceTraveled) + " mi."
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        locationManager.stopUpdatingLocation()
    }
}