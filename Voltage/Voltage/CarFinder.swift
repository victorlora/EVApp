//
//  CarFinder.swift
//  Voltage
//
//  Created by Josh Rosenzweig on 11/3/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import Foundation

/*This struct uses the String carFinderAPIKey and the edmunds
api to find the make of the vehicle using the users input*/
struct MakeFinder {
    
    let carFinderAPIKey: String             //String used to get a match in the API
    let carFinderBaseURL: NSURL?            //allows for a connection to the API
    
    init(APIKey: String) {
        carFinderAPIKey = APIKey
        carFinderBaseURL = NSURL(string: "http://api.edmunds.com/api/vehicle/v2/makes?fmt=json&api_key=\(carFinderAPIKey)&state=new&view=full")
    }
    
    /*This func uses the String manufacturer to get the make of the 
    vehicle the user is asking for by downloading the JSON from the API*/
    func getMake(manufacturer: String, completion: (CarMake? -> Void)) {
        // networkOperation is used in order to find the data the user is asking for
        if let carURL = NSURL(string: "\(manufacturer)", relativeToURL: carFinderBaseURL) {
            let networkOperation = NetworkOperation(url: carURL) 
            
            //The JSON file is found and the iteration is complete
            networkOperation.downloadJSONFromURL {
                (let JSONDictionary) in
                let finder = CarMake(Make: JSONDictionary!)
                completion(finder)
            }
        } else {
            // if no such file exists, then this error message is printed
            print("Could not construct a valid URL")
        }
    }

}

/* This struct uses the string carFinderAPIKey, carMake and the edmunds api
    in order to find the model the user asks for*/
struct ModelFinder {
        
    let carFinderAPIKey: String                 //String used to find a match in the API
    let carMake: String                         //String used to match carMake inputted and the strings in the API
    let carFinderBaseURL: NSURL?                //allows for a connection to the API
    
    // the carMake and CarFinderAPIkey are set here
    // and the api is set to carFinderBaseURL
    init(APIKey: String, Make: String) {
        carMake = Make
        carFinderAPIKey = APIKey
        carFinderBaseURL = NSURL(string: "http://api.edmunds.com/api/vehicle/v2/\(carMake)/models?fmt=json&api_key=\(carFinderAPIKey)&state=new&view=full")
        }
    }
