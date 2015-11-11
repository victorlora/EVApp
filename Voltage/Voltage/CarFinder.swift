//
//  CarFinder.swift
//  Voltage
//
//  Created by Josh Rosenzweig on 11/3/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import Foundation

struct MakeFinder {
    
    let carFinderAPIKey: String
    let carFinderBaseURL: NSURL?
    
    init(APIKey: String) {
        carFinderAPIKey = APIKey
        carFinderBaseURL = NSURL(string: "http://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=\(carFinderAPIKey)&state=new&view=full")
    }
    func getMake(manufacturer: String, completion: (CarMake? -> Void)) {
        if let carURL = NSURL(string: "\(manufacturer)", relativeToURL: carFinderBaseURL) {
            let networkOperation = NetworkOperation(url: carURL)
            
            networkOperation.downloadJSONFromURL {
                (let JSONDictionary) in
                let finder = CarMake(Make: JSONDictionary!)
                completion(finder)
            }
        } else {
            print("Could not construct a valid URL")
        }
    }

}

struct ModelFinder {
        
    let carFinderAPIKey: String
    let carMake: String
    let carFinderBaseURL: NSURL?
        
    init(APIKey: String, Make: String) {
        carMake = Make
        carFinderAPIKey = APIKey
        carFinderBaseURL = NSURL(string: "http://api.edmunds.com/api/vehicle/v2/\(carMake)/models?fmt=json&api_key=\(carFinderAPIKey)&state=new&view=full")
        }
    }
