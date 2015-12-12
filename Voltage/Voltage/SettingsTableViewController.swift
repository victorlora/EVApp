//
//  SettingsTableViewController.swift
//  Voltage
//
//  Created by Victor Lora on 12/5/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    //--------------UI Links--------------
    @IBOutlet var fuelSlider: UISlider!
    @IBOutlet var fuelAmt: UILabel!
    
    //--------------------------Functions--------------------------------
    
    // Allows user to select amount of fuel in gas-tank
    @IBAction func fuelSlider(sender: UISlider) {
        milesLeftEstimate = Double(fuelCap)! * Double(combinedMPG) * Double(fuelSlider.value) * 0.01
        fuelAmt.text = String(format: "%.0f", fuelSlider.value) + " %"
        NSUserDefaults.standardUserDefaults().setObject(milesLeftEstimate, forKey: "fuelEstimate")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fuelAmt.text = String(Int(fuelSlider.value)) + " %"
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
        carInfo = [String]()
    }
}
