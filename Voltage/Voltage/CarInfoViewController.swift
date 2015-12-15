//
//  CarInfoViewController.swift
//  Voltage
//
//  Created by EVApp Team on 11/26/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit

class CarInfoViewController: UIViewController, UITableViewDelegate {
    
    // UI Links
    @IBOutlet var carInfoTable: UITableView!
    @IBOutlet var carLogo: UIImageView!
    
    /* viewDidLoad()
    * @description
    *      Initial function call similar to main()
    */
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        getCarLogo()
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
        refreshAlert.addAction(UIAlertAction(title: "OK", style: .Default,
            handler: { (action: UIAlertAction!) in NSLog("OK was selected")
        }))
        
        presentViewController(refreshAlert, animated: true, completion: nil)
    }
    
    /* getCarLogo()
    * @description
    *      Loads appropriate car logo
    */
    func getCarLogo() {
        let maker = userMake.stringByReplacingOccurrencesOfString(" ", withString: "")
        let car = UIImage(named: "\(maker.lowercaseString).png")
        carLogo.image = car
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
    
    /* tableView()
    * @description
    *      Generates table containing all the items in the
    *      corresponding array
    */
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "Cell")
        
        cell.textLabel?.text = String(carInfo [indexPath.row])
        
        return cell
    }
}
