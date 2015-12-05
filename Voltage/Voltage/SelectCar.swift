//
//  SelectCar.swift
//  Voltage
//
//  Created by admin on 12/5/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit

class SelectCar: UIStoryboardSegue {
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        resetUserDefaults()
    }
    
    func resetUserDefaults() {
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "make")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "model")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "year")
        NSUserDefaults.standardUserDefaults().setObject(nil, forKey: "style")
    }
}
