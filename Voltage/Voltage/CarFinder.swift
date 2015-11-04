//
//  CarFinder.swift
//  Voltage
//
//  Created by Josh Rosenzweig on 11/3/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import Foundation

struct CarFinder {
    
    let carFinderAPIKey: String
    let carFinderBaseURL: NSURL?
    
    init(APIKey: String) {
        carFinderAPIKey = APIKey
        carFinderBaseURL = NSURL(string: "http://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key={\(carFinderAPIKey)}&state=new&view=full")
    }
}