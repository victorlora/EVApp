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
    
    //--------------------------Variables--------------------------------
    
    //---------Storyboard Links--------------
    @IBOutlet weak var carViewer: UITableView!
    @IBOutlet weak var carTaskLabel: UILabel!
    @IBOutlet weak var errorHandler: UILabel!

    @IBOutlet weak var carLogo: UIImageView!
    @IBOutlet weak var backButton: UIButton!

    @IBAction func backButton(sender: AnyObject) {
        handleBackButton()
    }
    
    //--------------API-----------------------
    private let API = "https://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=6m8ettta5byepu43rkhsc79j"
    private let APIKey = "6m8ettta5byepu43rkhsc79j"
    
    //----------API Generated Arrays----------
    var manufacturers = [String]()  // Array of manufacturer populated by API and displayed on the UI
    var models = [String]()         // Array of models that is populated by API upon Make selection
    var years = [String]()          // Array of years populated by API upon Make and Model selection

    //---------User Selections----------------
    var make:String = ""            // Stores user's make selection
    var model:String = ""           // Stores user's model selection
    var year:String = ""            // Stores user's year selection
    //-------------Temp Current----------------
    var currentPage = []        // Stores array of the current items to be selected (e.g. makes, models, etc.)
    var currentSelection = ""   // Stores users selection at each tableview

    let textCellIdentifier = "carChoice"    // Cell with carchoice (for tableview purposes)

    //--------------------------Functions--------------------------------
    
    /* viewDidLoad()
     * @description
     *      Initial function call similar to main()
     */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        carViewer.delegate = self
        carViewer.dataSource = self
        carTaskLabel.text = "Select Car Make"
        getMakes()
        self.currentPage = self.manufacturers
        configureView()
    }
    
    
    /* didReceiveMemoryWarning()
     * @description
     *      Used on large, memory intensive apps
     */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* switchToMake()
     * @description
     *      Sets the parameters for the "Select Make" view
     */
    
    func switchToMake() {
        self.manufacturers = [String]()
        getMakes()
        self.currentPage = self.manufacturers
        let car = UIImage(named: "tire.png")
        carLogo.image = car
        carTaskLabel.text = "Select Car Make"
        backButton.setTitle("", forState: .Normal)
        carViewer.reloadData()
    }
    
    /* switchToModel()
     * @description
     *      Sets the parameters for the "Select Model" view
     */
    
    func switchToModel() {
        self.models = [String]()
        getModels()
        self.currentPage = self.models
        let maker = make.stringByReplacingOccurrencesOfString(" ", withString: "")
        let car = UIImage(named: "\(maker.lowercaseString).png")
        carLogo.image = car
        carTaskLabel.text = "Select Car Model"
        backButton.setTitle("< Make", forState: .Normal)
        carViewer.reloadData()
    }
    
    /* switchToYear()
     * @description
     *      Sets the parameters for the "Select Year" view
     */
    
    func switchToYear() {
        self.years = [String]()
        getYears()
        self.currentPage = self.years
        //self.currentSelection = self.year
        carTaskLabel.text = "Select Car Year"
        backButton.setTitle("< Model", forState: .Normal)
        carViewer.reloadData()
    }
    
    func handleBackButton() {
        if (currentPage == models) {
            switchToMake()
        } else if (currentPage == years) {
            switchToModel()
        }
    }
    
    /* getMakes()
     * @description
     *      Makes API call and parses JSON to compile a list
     *       of car makes
     */
    
    func getMakes() {
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        let edmundsAPI: String = API
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
            errorHandler.text="Error finding makes"
        }
    }
    
    /* getModels()
     * @description
     *      Makes API call and parses JSON to compile a list
     *       of car models based on make
     */
    func getModels() {
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        let edmundsAPI: String = API
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
                                        self.models.append(carModel)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        } catch {
            errorHandler.text="Error finding models"
        }
    }
    
    /* getYears()
     * @description
     *      Makes API call and parses JSON to compile a list
     *       of car years based on make and model
     */
    
    func getYears() {
        
        // Setup the session to make REST GET call.  Notice the URL is https NOT http!!
        let edmundsAPI: String = API
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
                                                        self.years.append(String(carYear))
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
            errorHandler.text="Error finding years"
        }
    }

    /* configureView()
     * @description
     *      Configures UI display
     */

    func configureView() {
        carViewer.rowHeight = 36                            // Set custom height for table view rows
        carViewer.backgroundColor = UIColor.clearColor()    // sets table bg color
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
        return currentPage.count
    }

    /* tableView()
     * @description
     *      Generates table containing all the items in the
     *       corresponding array
     */
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = carViewer.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell
        let row = indexPath.row
        
        cell.textLabel?.text = currentPage[row] as? String
        
        return cell
    }
    
    /* tableView()
     * @description
     *      Handles table actions
     */
    
    func tableView(carViewer: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        carViewer.deselectRowAtIndexPath(indexPath, animated: true)
        let row = indexPath.row
        self.currentSelection = currentPage[row] as! String
        if (currentPage == manufacturers) {
            self.make = currentSelection
            switchToModel()
        } else if (currentPage == models) {
            self.model = currentSelection
            switchToYear()
        } else if (currentPage == years) {
            self.year = self.currentSelection
            carTaskLabel.text = "" + self.year + " " + self.make + " " + self.model
        }
    }

}

