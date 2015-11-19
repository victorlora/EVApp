//
//  CarMake.swift
//  Voltage
//
//  Created by Josh Rosenzweig on 11/4/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import Foundation
import UIKit

/* This struct sets Strings id and name in order to make
    API matches possible*/
struct CarMake {
    let id: String?
    let name: String?
    
    init(Make: [String: AnyObject]) {
        id = Make["id"] as? String
        name = Make["id"] as? String
    }
}
