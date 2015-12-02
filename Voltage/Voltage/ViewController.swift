//
//  ViewController.swift
//  Voltage
//
//  Created by Josh Rosenzweig on 11/2/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit
import Foundation



//---------Static User Selections----------------
var userMake:String = ""            // Stores user's make selection
var userModel:String = ""           // Stores user's model selection
var userYear:String = ""            // Stores user's year selection
var userStyle:String = ""           // Stores user's style selection

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    //--------------------------Variables--------------------------------
    
    //---------Storyboard Links--------------
    @IBOutlet weak var carViewer: UITableView!
    @IBOutlet weak var carTaskLabel: UILabel!
    @IBOutlet weak var errorHandler: UILabel!

    @IBOutlet weak var carLogo: UIImageView!
    @IBOutlet weak var backButton: UIButton!

    @IBAction func backButton(sender: AnyObject) {
        if (currentPage == models) {
            switchToMake()
        } else if (currentPage == years) {
            switchToModel()
        } else if (currentPage == styles) {
            switchToYear()
        }
    }
    
    //---------Car Save Toggle--------------
    @IBOutlet var saveCarLabel: UILabel!
    @IBOutlet var saveCar: UISwitch!
    @IBAction func saveCar(sender: AnyObject) {
        if (!saveSelection) {
            saveSelection = true
            saveCar.setOn(true, animated: true)
        } else {
            saveSelection = false
            saveCar.setOn(false, animated: true)
        }
    }
    
    @IBOutlet var continueButton: UIButton!
    
    var saveSelection = false       // User's choice to save their car
    
    //--------------API-----------------------
    private let API = "https://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=6m8ettta5byepu43rkhsc79j"
    private let APIKey = "6m8ettta5byepu43rkhsc79j"
    
    //----------API Generated Arrays----------
    var manufacturers = [String]()  // Array of manufacturer populated by API and displayed on the UI
    var models = [String]()         // Array of models that is populated by API upon Make selection
    var years = [String]()          // Array of years populated by API upon Make and Model selection
    var styles = [String]()

    
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
        configureView()         // Configure tableview
        // Check for user saved car data and perform segue if all data exists
        if (NSUserDefaults.standardUserDefaults().objectForKey("make") != nil) {
            userMake = NSUserDefaults.standardUserDefaults().objectForKey("make") as! String
            print (userMake)
            if (NSUserDefaults.standardUserDefaults().objectForKey("model") != nil) {
                userModel = NSUserDefaults.standardUserDefaults().objectForKey("model") as! String
                if (NSUserDefaults.standardUserDefaults().objectForKey("year") != nil) {
                    userYear = NSUserDefaults.standardUserDefaults().objectForKey("year") as! String
                    if (NSUserDefaults.standardUserDefaults().objectForKey("style") != nil) {
                        userStyle = NSUserDefaults.standardUserDefaults().objectForKey("style") as! String
                        dispatch_async(dispatch_get_main_queue()) {
                            [unowned self] in
                            self.performSegueWithIdentifier("homePage", sender: self)
                        }
                    } else {
                        switchToStyle()
                    }
                } else {
                    switchToYear()
                }
            } else {
                switchToModel()
            }
        } else {
            switchToMake()
            
        }
        
    }
    
    
    /* didReceiveMemoryWarning()
     * @description
     *      Used on large, memory intensive apps
     */
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        let refreshAlert = UIAlertController(title: "Refresh", message: "All data will be lost.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            print("Handle Ok logic here")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
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
        
        saveCar.setOn(false, animated: true)
        
        backButton.hidden = true
        saveCarLabel.hidden = false
        saveCar.hidden = false
        continueButton.hidden = true
        
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
        
        let maker = userMake.stringByReplacingOccurrencesOfString(" ", withString: "")
        
        let car = UIImage(named: "\(maker.lowercaseString).png")
        carLogo.image = car
        
        carTaskLabel.text = "Select Car Model"
        
        backButton.setTitle("Back", forState: .Normal)
        
        backButton.hidden = false
        backButton.setTitle("< Makes", forState: .Normal)
        saveCarLabel.hidden = true
        saveCar.hidden = true
        continueButton.hidden = true
        
        carViewer.reloadData()
    }
    
    /* switchToYear()
     * @description
     *      Sets the parameters for the "Select Year" view
     *
     */
    
    func switchToYear() {
        years = [String]()
        userYear = ""
        getYears()
        self.currentPage = years
        let maker = userMake.stringByReplacingOccurrencesOfString(" ", withString: "")
        let car = UIImage(named: "\(maker.lowercaseString).png")
        carLogo.image = car
        carTaskLabel.text = "Select Car Year"
        backButton.setTitle("Back", forState: .Normal)
        
        backButton.hidden = false
        backButton.setTitle("< Models", forState: .Normal)
        saveCarLabel.hidden = true
        saveCar.hidden = true
        continueButton.hidden = true
        
        carViewer.reloadData()
    }
    
    func switchToStyle() {
        styles = [String]()
        userStyle = ""
        getStyles()
        self.currentPage = styles
        let maker = userMake.stringByReplacingOccurrencesOfString(" ", withString: "")
        let car = UIImage(named: "\(maker.lowercaseString).png")
        carLogo.image = car
        carTaskLabel.text = "Select Car Style"
        backButton.setTitle("Back", forState: .Normal)
        
        backButton.hidden = false
        backButton.setTitle("< Years", forState: .Normal)
        saveCarLabel.hidden = true
        saveCar.hidden = true
        
        carViewer.reloadData()
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
                    if let name = model["name"] as? String {
                        self.models.append(name)
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
                        if name.isEqual(userMake) {
                            if let models = make["models"] as? [[String: AnyObject]] {
                                for model in models {
                                    if let carModel = model["name"] as? String {
                                        if carModel.isEqual(userModel) {
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
    
    func getStyles() {
        
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
                                            if let styles = year["styles"] as? [[String: AnyObject]] {
                                                for style in styles {
                                                    if let carStyle = style["name"] as? String {
                                                        self.styles.append(carStyle)
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
            errorHandler.text="Error finding styles"
        }
    }

    
    /* getCarInfo()
    * @description
    *      Makes API call and parses JSON to compile a list
    *       of car years based on make and model
    */
    
    func getCarInfo() {
//        print(userMake + " " + userModel + " " + userYear)
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
            userMake = currentSelection
            if (saveSelection) {
                NSUserDefaults.standardUserDefaults().setObject(currentSelection, forKey: "make")
            }
            switchToModel()
        } else if (currentPage == models) {
            userModel = currentSelection
            if (saveSelection) {
                NSUserDefaults.standardUserDefaults().setObject(currentSelection, forKey: "model")
            }
            switchToYear()
        } else if (currentPage == years) {
            userYear = self.currentSelection
            if (saveSelection) {
                NSUserDefaults.standardUserDefaults().setObject(currentSelection, forKey: "year")
            }
            switchToStyle()
        } else if (currentPage == styles) {
            userStyle = self.currentSelection
            if (saveSelection) {
                NSUserDefaults.standardUserDefaults().setObject(currentSelection, forKey: "style")
            }
            
            if (!userStyle.isEmpty) {
                continueButton.hidden = false
            }
            
            carTaskLabel.text = "" + userYear + " " + userMake + " " + userModel + " " + userStyle
        }
    }

}

