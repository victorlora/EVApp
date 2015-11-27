//
//  CarInfoViewController.swift
//  Voltage
//
//  Created by admin on 11/26/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit

class CarInfoViewController: UIViewController {
    
    private let APIKey = "6m8ettta5byepu43rkhsc79j"
    
    var id = ""

//    private let API = "https://api.edmunds.com/api/vehicle/v2/styles/200477947/engines?fmt=json&api_key={api key}"
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getStyleId()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /* getCarInfo()
    * @description
    *      Makes API call and parses JSON to compile a list
    *       of car information based on user's car selection
    */
    
    func getStyleId() {
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        let edmundsAPI: String = "https://api.edmunds.com/api/vehicle/v2/\(userMake.stringByReplacingOccurrencesOfString(" ", withString: "_"))/models?fmt=json&api_key=6m8ettta5byepu43rkhsc79j"
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
                                            print(carYear)
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

    

//    func resetUserDefaults() {
//        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "make")
//        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "model")
//        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "year")
//    }

}
