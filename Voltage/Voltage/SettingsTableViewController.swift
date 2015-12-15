//
//  SettingsTableViewController.swift
//  Voltage
//
//  Created by EVApp Team on 12/5/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit

var globalFirstName:String = ""
var globalLastName:String = ""
class SettingsTableViewController: UITableViewController {
    
    //--------------UI Links--------------
    @IBOutlet var firstName: UITextField!
    @IBOutlet var lastName: UITextField!
    @IBOutlet var fuelSlider: UISlider!
    @IBOutlet var fuelAmt: UILabel!
    
    //--------------------------Functions--------------------------------
    
    // Allows user to select amount of fuel in gas-tank
    @IBAction func fuelSlider(sender: UISlider) {
        if (Double(fuelCap) != nil && combinedMPG != 0) {
            milesLeftEstimate = Double(fuelCap)! * Double(combinedMPG) * Double(fuelSlider.value) * 0.01
            fuelAmt.text = String(format: "%.0f", fuelSlider.value) + " %"
            NSUserDefaults.standardUserDefaults().setObject(milesLeftEstimate, forKey: "fuelEstimate")
        } else {
            NSLog("fuel cap not available for this vehicle")
            let alert = UIAlertController(title: "Alert!", message: "This function is not available for the selected vehicle.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: .Default, handler:
                { (action: UIAlertAction!) in
                    NSLog("OK Pressed")
            }))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fuelAmt.text = String(Int(fuelSlider.value)) + " %"
        if (milesLeftEstimate != -1) {
            if (Double(fuelCap) != nil) {
                fuelSlider.value =  Float(milesLeftEstimate / (Double(fuelCap)! * Double(combinedMPG))) * 100
            }
            fuelAmt.text = String(format: "%.0f", fuelSlider.value) + " %"
        }
        if (NSUserDefaults.standardUserDefaults().objectForKey("firstName") != nil) {
            self.firstName.text = NSUserDefaults.standardUserDefaults().objectForKey("firstName") as! String!
        }
        if (NSUserDefaults.standardUserDefaults().objectForKey("lastName") != nil) {
            self.lastName.text = NSUserDefaults.standardUserDefaults().objectForKey("lastName") as! String!
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        let refreshAlert = UIAlertController(title: "Memory Warning", message: "All data cannot be saved.", preferredStyle: UIAlertControllerStyle.Alert)
        
        refreshAlert.addAction(UIAlertAction(title: "Ok", style: .Default, handler: { (action: UIAlertAction!) in
            
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    /* prepareForSegue()
    * @description
    *      Performs before segue is made
    */
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Resets user defaults to nil when the user decides to change cars
        if (segue.identifier == "selectCar") {
            resetUserDefaults()
        }
        
        globalFirstName = String(self.firstName.text!)
        globalLastName  = String(self.lastName.text!)
        NSUserDefaults.standardUserDefaults().setObject(globalFirstName, forKey: "firstName")
        NSUserDefaults.standardUserDefaults().setObject(globalLastName, forKey: "lastName")
    }
    
    /* resetUserDefaults()
    * @description
    *      Resets all user defaults to nil
    */
    
    func resetUserDefaults() {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "make")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "model")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "year")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "style")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "fuelEstimate")
        combinedMPG = 0
        carInfo = [String]()
    }
    
    /* touchesBegan() & textFieldShould Return()
    *  @description
    *      Allows user to exit keyboard layout by touching away from keyboard
    */
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(textField: UITextField!) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
}
