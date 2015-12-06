//
//  SettingsTableViewController.swift
//  Voltage
//
//  Created by admin on 12/5/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    @IBOutlet var fuelSlider: UISlider!
    @IBOutlet var fuelAmt: UILabel!
    
    @IBAction func fuelSlider(sender: UISlider) {
        fuelEstimate = Double(fuelCap)! * Double(combinedMPG) * Double(fuelSlider.value) * 0.01
        fuelAmt.text = String(format: "%.0f", fuelSlider.value) + " %"
        NSUserDefaults.standardUserDefaults().setObject(fuelEstimate, forKey: "fuelEstimate")
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
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if (segue.identifier == "selectCar") {
            resetUserDefaults()
        }
    }
    
    func resetUserDefaults() {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "make")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "model")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "year")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "style")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "fuelEstimate")
        carInfo = [String]()
    }
}
