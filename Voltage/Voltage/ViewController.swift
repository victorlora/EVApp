//
//  ViewController.swift
//  Voltage
//
//  Created by Josh Rosenzweig on 11/2/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    let url = "https://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=6m8ettta5byepu43rkhsc79j"
    
    @IBOutlet weak var carViewer: UITableView!
    @IBOutlet weak var carTaskLabel: UILabel!
    
    private let carFinderAPIKey = "6m8ettta5byepu43rkhsc79j"

    let textCellIdentifier = "carChoice"
    let manufacturers = ["AM General", "Acura", "Alfa Romeo", "Aston Martin", "Audi", "BMW", "Bentley", "Buick","Cadillac", "Chevrolet", "Chrysler", "Daewoo", "Dodge", "Eagle", "Fiat", "Ferrari", "Fisker", "Ford", "GMC", "Geo", "Hummer", "Honda", "Hyundai", "Infiniti", "Isuzu", "Jaguar", "Jeep", "Kia", "Lamborghini", "Land Rover", "Lexus", "Lincoln", "Lotus","Maserati", "Mini", "Maybach", "Mazda", "Mercedes Benz", "Mercury", "Mitsubishi", "Nissan", "Oldsmobile", "Panoz", "Plymouth", "Pontiac", "Porsche", "Ram", "Rolls Royce", "Saab", "Saturn", "Scion", "Spyker", "Subaru", "Suzuki", "Tesla", "Toyota", "Volkswagen", "Volvo", "Smart",  ]
    
    let makes = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        carViewer.delegate = self
        carViewer.dataSource = self
        carTaskLabel.text = "Select Car Make"
        configureView()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMakes() {
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        let edmundsAPI: String = "https://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=6m8ettta5byepu43rkhsc79j"
        let session = NSURLSession.sharedSession()
        let url = NSURL(string: edmundsAPI)!
        
        // Make the POST call and handle it in a completion handler
        session.dataTaskWithURL(url, completionHandler: { ( data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            // Make sure we get an OK response
            guard let realResponse = response as? NSHTTPURLResponse where
                realResponse.statusCode == 200 else {
                    print("Not a 200 response")
                    return
            }
            
            // Read the JSON
            do {
                if let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments) as? NSDictionary {
                    print(json)
                    // parse json here
                }
            } catch {
                print("bad things happened")
            }
        }).resume()
    }


    func configureView() {
        // Set custom height for table view row
        carViewer.rowHeight = 36
        carViewer.backgroundColor = UIColor.blackColor()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manufacturers.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = carViewer.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell

        let row = indexPath.row
        
        cell.textLabel?.text = manufacturers[row]
        return cell
        
    }
    
    func tableView(carViewer: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        getMakes()
        carViewer.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        print(manufacturers[row])
    }
}

