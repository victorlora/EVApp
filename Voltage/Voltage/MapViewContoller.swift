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
    
    var locationManager = CLLocationManager()
    var startingLocation = ""
    
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
        print(locations)
        let userLocation: CLLocation = locations[0]
        
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
        speedLabel.text = String(format: "%.2f", userLocation.speed * 2.23694)

    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        locationManager.stopUpdatingLocation()
    }
}