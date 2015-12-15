//
//  MainMenuViewController.swift
//  Voltage
//
//  Created by EVApp Team on 11/29/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit
import SystemConfiguration


// Global variables
var carInfo = [String]()            // List of car information
var styleId = ""                    // Stores style id
var mpgCity:Int = 0                 // Stores city mpg
var mpgHighway:Int = 0              // Stores highway mpg
var combinedMPG = 0                 // Stores combined mpg
var fuelCap = ""                    // Stores fuel tank capacity
var engType = ""                    // Stores engine type
var milesLeftEstimate: Double = 0   // Stores mileage remaining estimate

class MainMenuViewController: UIViewController {
    
    // UI Links
    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet var greetingLabel: UILabel!
    
    var time = NSTimer()        // Timer
    let factBook = FactBookEV() // Factbook
    
    // API Key
    private let APIKey = "6m8ettta5byepu43rkhsc79j"
    
    // Functions
    
    /* viewDidLoad()
    * @description
    *      Initial function call similar to main()
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        var greeting = "EVApp"
        
        // Gather information necessary to acquire hour
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components(.Hour, fromDate: NSDate())
        let hour = components.hour
        
        // Set appropriate greeting
        if (hour >= 12 && hour <= 17) {
            greeting = "Good afternoon"
        } else if (hour >= 17 && hour <= 23){
            greeting = "Good evening"
        } else {
            greeting = "Good morning"
        }
        
        greetingLabel.text = greeting
        
        // Retrieve user's name from memory
        if (NSUserDefaults.standardUserDefaults().objectForKey("firstName") != nil) {
            globalFirstName = NSUserDefaults.standardUserDefaults().objectForKey("firstName") as! String!
        }
        
        if (NSUserDefaults.standardUserDefaults().objectForKey("lastName") != nil) {
            globalLastName = NSUserDefaults.standardUserDefaults().objectForKey("lastName") as! String!
        }
        
        // Set greeting
        if (globalFirstName.characters.count > 0){
            greetingLabel.text = greeting + ", " + globalFirstName + "!"
        } else {
            greetingLabel.text = greeting + "!"
        }
        
        
        if isConnectedToNetwork() == true {
            showFunFact()
            getStyleId()
            getCarInfo()
            getTankCapacity()
            time = .scheduledTimerWithTimeInterval(5, target: self,
                selector: Selector("showFunFact"), userInfo: nil, repeats: true)
            
            if (NSUserDefaults.standardUserDefaults().objectForKey("fuelEstimate") != nil) {
                milesLeftEstimate = NSUserDefaults.standardUserDefaults().objectForKey("fuelEstimate") as! Double
            }
            
        } else {
            let refreshAlert = UIAlertController(title: "No Internet Connection",
                message: "Retry When There is a Connection",
                preferredStyle: UIAlertControllerStyle.Alert)
            refreshAlert.addAction(UIAlertAction(title: "Retry", style: .Default,
                handler: { (action: UIAlertAction!) in
                    self.getStyleId()
                    self.getCarInfo()
                    self.getTankCapacity()
            }))
            dispatch_async(dispatch_get_main_queue(), {
                self.presentViewController(refreshAlert, animated: true, completion: nil)
            })
            
        }
    }
    
    /* didReceiveMemoryWarning()
    * @description
    *      Used on large, memory intensive apps
    */
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        let refreshAlert = UIAlertController(title: "Memory Warning",
            message: "All data cannot be saved.",
            preferredStyle: UIAlertControllerStyle.Alert)
        refreshAlert.addAction(UIAlertAction(title: "OK!", style: .Default,
            handler: { (action: UIAlertAction!) in NSLog("OK clicked.")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    /* isConnectedToNetwork()
    * @description
    *      Checks for network connection
    */
    func isConnectedToNetwork() -> Bool {
        
        var blankAddress = sockaddr_in(sin_len: 0, sin_family: 0, sin_port: 0,
            sin_addr: in_addr(s_addr: 0), sin_zero: (0, 0, 0, 0, 0, 0, 0, 0))
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
    
    /* showFunFact()
    * @description
    *       displays random fact fact every 5s.
    */
    @IBAction func showFunFact(){
        funFactLabel.text = factBook.randomFact()
    }
    
    /* getCarStyleId()
    * @description
    *      Makes API call and parses JSON to get a car's
    *      style ID based on user's car selection
    */
    func getStyleId() {
        
        // Setup the session to make REST GET call.  
        // Notice the URL is https NOT http!!
        let edmundsAPI: String = "https://api.edmunds.com/api/vehicle/v2/"
                                + "\(userMake.stringByReplacingOccurrencesOfString(" ", withString: "_"))"
                                + "/models?fmt=json&api_key=\(APIKey)"
        let url = NSURL(string: edmundsAPI)!    // Call API
        let data = NSData(contentsOfURL: url)!  // Get JSON data
        
        do {                                    // Read JSON
            let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data,
                options: .AllowFragments) as! NSDictionary
            
            if let models = json["models"] as? [[String: AnyObject]] {  // Parse JSON
                
                for model in models {
                    if let carModel = model["name"] as? String {
                        if carModel.isEqual(userModel) {
                            if let years = model["years"] as? [[String: AnyObject]] {
                                for year in years {
                                    if let carYear = year["year"] as? Int {
                                        if (carYear == Int(userYear)) {
                                            if let styles = year["styles"] as? [[String: AnyObject]] {
                                                for style in styles {
                                                    if let carStyle = style["name"] as? String {
                                                        if carStyle.isEqual(userStyle) {
                                                            if (style["id"] != nil) {
                                                                styleId = String(style["id"]!)
                                                            }
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch {
            NSLog("Error getting car style id")
        }
    }
    
    /* getCarInfo()
    * @description
    *      Makes API call and parses JSON to get a car's
    *      information based on the user's selection
    */
    func getCarInfo() {
        carInfo = [String]()
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        let url = NSURL(string: "https://api.edmunds.com/api/vehicle/v2/styles/"
                                + "\(styleId)?view=full&fmt=json&api_key=\(APIKey)")!
        let data = NSData(contentsOfURL: url)!  // Get JSON data
        
        do {                                    // Read the JSON
            let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data,
                options: .AllowFragments) as! NSDictionary
            
            if let engineSpecs = json["engine"] as? NSDictionary {  // Parse JSON
                carInfo.append("Vehicle:")
                carInfo.append("\t Make: " + userMake)
                carInfo.append("\t Model: " + userModel)
                carInfo.append("\t Year: " + userYear)
                carInfo.append("Engine Specs:")
                
                if let cylinders = engineSpecs["cylinder"] as? Int {
                    carInfo.append("\t Cylinders: \(cylinders)")
                }
                if let bhp = engineSpecs["horsepower"] as? Int {
                    carInfo.append("\t Horsepower: \(bhp)")
                }
                if let torq = engineSpecs["torque"] as? Int {
                    carInfo.append("\t Torque: \(torq)")
                }
                
                engType = (engineSpecs["type"] as? String)!
                carInfo.append("\t Engine Type: \(engType)")
            }
            if let tranSpecs = json["transmission"] as? NSDictionary {
                carInfo.append("Transmission Specs:")
                
                if let transType = tranSpecs["transmissionType"] as? String {
                    carInfo.append("\t Transmission Type: \(transType)")
                }
                if let numSpeeds = tranSpecs["numberOfSpeeds"] as? String {
                    carInfo.append("\t Number of Speeds: \(numSpeeds)")
                }
            }
            if let MPG = json["MPG"] as? NSDictionary {
                carInfo.append("MPG:")
                if let city = MPG["city"] as? String {
                    mpgCity = Int(city)!
                    carInfo.append("\t City: \(city)")
                }
                if let highway = MPG["highway"] as? String {
                    mpgHighway = Int(highway)!
                    carInfo.append("\t Highway: \(highway)")
                }
                combinedMPG = (mpgCity + mpgHighway) / 2
                carInfo.append("\t Combined: \(combinedMPG)")
            }
        } catch {
            NSLog("Error getting car info")
        }
        
    }
    
    /* getTankCapacity()
    * @description
    *      Makes API call and parses JSON to get a car's
    *      tank capacity
    */
    func getTankCapacity() {
        // Setup the session to make REST GET call.  
        // Notice the URL is https NOT http!!
        let url = NSURL(string: "https://api.edmunds.com/api/vehicle/v2/styles/\(styleId)/equipment?"
            + "availability=standard&equipmentType=OTHER&fmt=json&api_key=\(APIKey)")!
        let data = NSData(contentsOfURL: url)!  // Get JSON data
        
        do {                                    // Read the JSON
            let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
            
            if let equipment = json["equipment"] as? [[String: AnyObject]] {    // Parse JSON
                for item in equipment {
                    if let name = item["name"] as? String {
                        if name.isEqual("Specifications") {
                            if let attributes = item["attributes"] as? [[String: AnyObject]] {
                                for attribute in attributes {
                                    if let id = attribute["name"] as? String {
                                        if id.isEqual("Fuel Capacity") {
                                            if let fuelCapacity = attribute["value"] as? String {
                                                fuelCap = fuelCapacity
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch {
            NSLog("Error getting tank capacity")
        }
    }
}
