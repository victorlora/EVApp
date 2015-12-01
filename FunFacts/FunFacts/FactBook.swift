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
    "Ants stretch when they wake up in the morning.",
    "Ostriches can run faster than horses.",
    "Olympic gold medals are actually mostly made of silver.",
    "You are born with 300 bones; by the time you are an adult you have 206.",
    "It takes about 8 minutes for light from the sun to reach Earth.",
    "Some bamboo plants can grow almost a meter in one day.",
    "Some penguins can leap 2-3 meters out of the water.",
    "The state of Florida is bigger than England.",
    "On average it takes 66 days to form a new habit.",
    "Mammoths still walked the Earth when the Great Pyramid was being built."
    ]
    
    func randomFact() -> String {
    let unsignedArrayCount = UInt32(factsArray.count)
    let unsignedRandomNumber = arc4random_uniform(unsignedArrayCount)
    let randomNumber = Int(unsignedRandomNumber)
        
    return factsArray[randomNumber]
    }
}