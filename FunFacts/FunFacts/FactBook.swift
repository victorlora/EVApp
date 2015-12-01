//
//  FactBook.swift
//  FunFacts
//
//  Created by Josh Rosenzweig on 8/4/15.
//  Copyright (c) 2015 Volt. All rights reserved.
//

import Foundation

struct FactBook {
    let factsArray = [
   	“The average American's daily round trip is less than 30 miles”
	“Electric cars emit no tailpipe pollutants when running on electricity”
	“All Electric cars (even hybrids) use an electric motor”
	“Electric vehicles are much quieter than gasoline powered vehicles”
	“Electric vehicles are made with fewer parts”
	“Electric vehicles are as comfortable as gasoline powered vehicles”
	“Electric vehicles are as safe as gasoline powered vehicles”
	“Electric vehicles are as durable as gasoline powered vehicles”
	“Electric vehicles can be as powerful as gasoline powered vehicles”
	“Many models of electric cars switch to a gasoline-powered engines”
	“Electric-powered vehicles do not require exhaust or emission tests”
	“Electric vehicle owners are eligible for a tax credit of up to $7,500 from 	the federal government”
	“Many states and local governments offer incentives to EV owners”
	“NYC taxis were once primarily powered by electricity”
	“Electricity prices are much more stable than gasoline prices”
	“On average EV drivers pay $1.20 to drive the same distance a conventional 		car could go on a gallon”
	“All-electric vehicles contain fewer fluids (like oil and transmission 		fluid)”
	“EV drivers can save $750 to $1,200 dollars a year compared to operating an 	average new compact gasoline vehicle (27 mpg, $3.50/gal)”
	“An average American spends $3000 – $4000 on gas each year”
	“EVs produce lower global warming emissions than the most fuel-efficient 		hybrids”
	“EVs charged entirely from renewable sources produce no global warming 		emissions”
	“Take advantage of rate plans that offer lower-cost electricity at night. it 	can mean saving hundreds”
	“The average electric vehicle can run for 40 to 100 miles on one charge”

    ]
    
    func randomFact() -> String {
    let unsignedArrayCount = UInt32(factsArray.count)
    let unsignedRandomNumber = arc4random_uniform(unsignedArrayCount)
    let randomNumber = Int(unsignedRandomNumber)
        
    return factsArray[randomNumber]
    }
}