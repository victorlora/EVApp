//
//  MainMenuViewController.swift
//  Voltage
//
//  Created by admin on 11/29/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit

var carInfo = [String]()
var id = ""

var mpgCity:Int = 0
var mpgHighway:Int = 0
var combinedMPG = 0
var fuelCap = ""

class MainMenuViewController: UIViewController {
    

    @IBOutlet weak var funFactLabel: UILabel!
    
    var time = NSTimer()
    
    let factBook = FactBookEV()
    
    private let APIKey = "6m8ettta5byepu43rkhsc79j"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showFunFact();
        time = .scheduledTimerWithTimeInterval(5, target: self, selector: Selector("showFunFact"), userInfo: nil, repeats: true)
        getStyleId()
        getCarInfo()
        getTankCapacity()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        let refreshAlert = UIAlertController(title: "Memory Warning", message: "All data cannot be saved.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    @IBAction func showFunFact(){
        funFactLabel.text = factBook.randomFact()
    }

    /* getCarStyleId()
    * @description
    *      Makes API call and parses JSON to get a car's
    *      style ID based on user's car selection
    */
    
    func getStyleId() {
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        let edmundsAPI: String = "https://api.edmunds.com/api/vehicle/v2/\(userMake.stringByReplacingOccurrencesOfString(" ", withString: "_"))/models?fmt=json&api_key=\(APIKey)"
        let url = NSURL(string: edmundsAPI)!
        
        // Get JSON data
        let data = NSData(contentsOfURL: url)!
        
        // Read the JSON
        do {
            let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
            // Parse JSON
            if let models = json["models"] as? [[String: AnyObject]] {
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
                                                                id = String(style["id"]!)
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
            //errorHandler.text="Error finding id"
        }
    }
    
    /* getCarInfo()
    * @description
    *      Makes API call and parses JSON to get a car's
    *      information based on the user's selection
    */
    
    func getCarInfo() {
        
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        let url = NSURL(string: "https://api.edmunds.com/api/vehicle/v2/styles/\(id)?view=full&fmt=json&api_key=\(APIKey)")!
        
        // Get JSON data
        let data = NSData(contentsOfURL: url)!
        
        // Read the JSON
        do {
            let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
            // Parse JSON
            if let engineSpecs = json["engine"] as? NSDictionary {
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
                if let engType = engineSpecs["type"] as? String {
                    carInfo.append("\t Engine Type: \(engType)")
                }
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
            //errorHandler.text="Error finding makes"
        }
        
    }
    
    func getTankCapacity() {
        
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        let url = NSURL(string: "https://api.edmunds.com/api/vehicle/v2/styles/\(id)/equipment?availability=standard&equipmentType=OTHER&fmt=json&api_key=\(APIKey)")!
        
        // Get JSON data
        let data = NSData(contentsOfURL: url)!
        
        // Read the JSON
        do {
            let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
            // Parse JSON
            if let equipment = json["equipment"] as? [[String: AnyObject]] {
                for item in equipment {
                    if let name = item["name"] as? String {
                        if name.isEqual("Specifications") {
                            if let attributes = item["attributes"] as? [[String: AnyObject]] {
                                for attribute in attributes {
                                    if let id = attribute["name"] as? String {
                                        if id.isEqual("Fuel Capacity") {
                                            if let fuelCapacity = attribute["value"] as? String {
                                                fuelCap = fuelCapacity
                                                carInfo.append("\t Fuel Capacity: " + fuelCap + " gal.")
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
            //errorHandler.text="Error finding makes"
        }
        
    }



}
