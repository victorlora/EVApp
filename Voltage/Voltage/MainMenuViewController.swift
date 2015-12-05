//
//  MainMenuViewController.swift
//  Voltage
//
//  Created by admin on 11/29/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController {

    @IBOutlet weak var funFactLabel: UILabel!
    
    var time = NSTimer()
    
    let factBook = FactBookEV()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showFunFact();
        time = .scheduledTimerWithTimeInterval(5, target: self, selector: Selector("showFunFact"), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
