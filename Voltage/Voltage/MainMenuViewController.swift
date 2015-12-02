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
        time = .scheduledTimerWithTimeInterval(5, target: self, selector: Selector("showFunFact"), userInfo: nil, repeats: true)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        resetUserDefaults()
    }
    func resetUserDefaults() {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "make")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "model")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "year")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "style")
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
