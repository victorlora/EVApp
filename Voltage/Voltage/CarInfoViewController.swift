//
//  CarInfoViewController.swift
//  Voltage
//
//  Created by admin on 11/26/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit

class CarInfoViewController: UIViewController, UITableViewDelegate {
    
    private let APIKey = "6m8ettta5byepu43rkhsc79j"
    
    var carInfo = [String]()
    var id = ""
    
    var mpgCity:Int = 0
    var mpgHighway:Int = 0
    var combinedMPG = 0
    
    @IBOutlet var carInfoTable: UITableView!
    @IBOutlet var carLogo: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getCarLogo()
        getStyleId()
        getCarInfo()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        let refreshAlert = UIAlertController(title: "Refresh", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    /* numberOfSectionsInTableView()
    * @returns
    *      Number of columns in tableView
    */
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    /* tableView()
    * @returns
    *      Number of items in current array for tableview rows
    */
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carInfo.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = String(carInfo [indexPath.row])
        
        return cell
    }
    
    func getCarLogo() {
        let maker = userMake.stringByReplacingOccurrencesOfString(" ", withString: "")
        let car = UIImage(named: "\(maker.lowercaseString).png")
        carLogo.image = car
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
                                                                self.id = String(style["id"]!)
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
        let url = NSURL(string: "https://api.edmunds.com/api/vehicle/v2/styles/\(self.id)?view=full&fmt=json&api_key=\(APIKey)")!
        
        // Get JSON data
        let data = NSData(contentsOfURL: url)!
        
        // Read the JSON
        do {
            let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
            // Parse JSON
            if let engineSpecs = json["engine"] as? NSDictionary {
                self.carInfo.append("Engine Specs:")
                if let cylinders = engineSpecs["cylinder"] as? Int {
                    self.carInfo.append("\t Cylinders: \(cylinders)")
                }
                if let bhp = engineSpecs["horsepower"] as? Int {
                    self.carInfo.append("\t Horsepower: \(bhp)")
                }
                if let torq = engineSpecs["torque"] as? Int {
                    self.carInfo.append("\t Torque: \(torq)")
                }
                if let engType = engineSpecs["type"] as? String {
                    self.carInfo.append("\t Engine Type: \(engType)")
                }
            }
            if let tranSpecs = json["transmission"] as? NSDictionary {
                self.carInfo.append("Transmission Specs:")
                if let transType = tranSpecs["transmissionType"] as? String {
                    self.carInfo.append("\t Transmission Type: \(transType)")
                }
                if let numSpeeds = tranSpecs["numberOfSpeeds"] as? String {
                    self.carInfo.append("\t Number of Speeds: \(numSpeeds)")
                }
            }
            if let MPG = json["MPG"] as? NSDictionary {
                self.carInfo.append("MPG:")
                if let city = MPG["city"] as? String {
                    self.mpgCity = Int(city)!
                    self.carInfo.append("\t City: \(city)")
                }
                if let highway = MPG["highway"] as? String {
                    self.mpgHighway = Int(highway)!
                    self.carInfo.append("\t Highway: \(highway)")
                }
                self.combinedMPG = (self.mpgCity + self.mpgHighway) / 2
                self.carInfo.append("\t Combined: \(self.combinedMPG)")
            }
        } catch {
            //errorHandler.text="Error finding makes"
        }

        carInfoTable.reloadData()
    }
}
