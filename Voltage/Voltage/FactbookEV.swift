//
//  FactbookEV.swift
//  Voltage
//
//  Created by Ron Gerschel on 12/1/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import Foundation

struct FactBookEV {
    let factsArray = [
        "The average American's daily round trip is less than 30 miles",
        "Electric cars emit no tailpipe pollutants when running on electricity",
        "All Electric cars (even hybrids) use an electric motor",
        "Electric vehicles are much quieter than gasoline powered vehicles",
        "Electric vehicles are made with fewer parts",
        "Electric vehicles are as comfortable as gasoline powered vehicles",
        "Electric vehicles are as safe as gasoline powered vehicles",
        "Electric vehicles are as durable as gasoline powered vehicles",
        "Electric vehicles can be as powerful as gasoline powered vehicles",
        "Many models of electric cars switch to a gasoline-powered engines",
        "Electric-powered vehicles do not require exhaust or emission tests",
        "Electric vehicle owners are eligible for a tax credit of up to $7,500 from the federal government",
        "Many states and local governments offer incentives to EV owners",
        "NYC taxis were once primarily powered by electricity",
        "Electricity prices are much more stable than gasoline prices",
        "On average EV drivers pay $1.20 to drive the same distance a conventional car could go on a gallon",
    ]
    
    func randomFact() -> String {
        let unsignedArrayCount = UInt32(factsArray.count)
        let unsignedRandomNumber = arc4random_uniform(unsignedArrayCount)
        let randomNumber = Int(unsignedRandomNumber)
        
        return factsArray[randomNumber]
    }
}