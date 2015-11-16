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
    
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    let makeAPI = "https://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=6m8ettta5byepu43rkhsc79j"
    
    var make:String = ""
    var model:String = "200" // make "" filling in until UI makes selections
    var year:String = ""
    
    var manufacturers = [String]()
    var models = [String]()
    var years = [Int]()
    
    @IBOutlet weak var carViewer: UITableView!
    @IBOutlet weak var carTaskLabel: UILabel!
    
    private let carFinderAPIKey = "6m8ettta5byepu43rkhsc79j"

    let textCellIdentifier = "carChoice"

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        carViewer.delegate = self
        carViewer.dataSource = self
        carTaskLabel.text = "Select Car Make"
        getMakes()
        configureView()
    }
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getMakes() {
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        let edmundsAPI: String = makeAPI
        let url = NSURL(string: edmundsAPI)!
        
        // Get JSON data
        let data = NSData(contentsOfURL: url)!
        
        // Read the JSON
        do {
            let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
            // Parse JSON
            if let makes = json["makes"] as? [[String: AnyObject]] {
                for make in makes {
                    if let name = make["name"] as? String {
                        self.manufacturers.append(name)
                    }
                }
            }

        } catch {
            print("bad things happened")
        }
    }
    
    func getModels() {
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        let edmundsAPI: String = makeAPI
        let url = NSURL(string: edmundsAPI)!
        
        // Get JSON data
        let data = NSData(contentsOfURL: url)!
        
        // Read the JSON
        do {
            let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
            // Parse JSON
            if let makes = json["makes"] as? [[String: AnyObject]] {
                for make in makes {
                    if let name = make["name"] as? String {
                        if name.isEqual(self.make) {
                            if let models = make["models"] as? [[String: AnyObject]] {
                                for model in models {
                                    if let carModel = model["name"] as? String {
                                        print(carModel) // Remove: debug purpose only
                                        self.models.append(carModel)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        } catch {
            print("bad things happened")
        }
        getYears()
    }
    
    func getYears() {
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        let edmundsAPI: String = makeAPI
        let url = NSURL(string: edmundsAPI)!
        
        // Get JSON data
        let data = NSData(contentsOfURL: url)!
        
        // Read the JSON
        do {
            let json: NSDictionary = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments) as! NSDictionary
            // Parse JSON
            if let makes = json["makes"] as? [[String: AnyObject]] {
                for make in makes {
                    if let name = make["name"] as? String {
                        if name.isEqual(self.make) {
                            if let models = make["models"] as? [[String: AnyObject]] {
                                for model in models {
                                    if let carModel = model["name"] as? String {
                                        if carModel.isEqual(self.model) {
                                            if let years = model["years"] as? [[String: AnyObject]] {
                                                for year in years {
                                                    if let carYear = year["year"] as? Int {
                                                        print(carYear) // Remove: debug purpose only
                                                        self.years.append(carYear)
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
            print("bad things happened")
        }
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
        carViewer.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        self.make = manufacturers[row]
        getModels()
        print(self.make)
    }
}

