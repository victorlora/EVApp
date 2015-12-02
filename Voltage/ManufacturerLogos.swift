//
//  ManufacturerLogos.swift
//  Voltage
//
//  Created by Josh Rosenzweig on 11/17/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import Foundation
import UIKit

enum Icon: String {
    case AMGeneral = "amgeneral"
    case Acura = "acura"
    case AlfaRomeo = "alfaromeo"
    case AstonMartin = "astonmartin"
    case Audi = "audi"
    case BMW = "bmw"
    case Bentley = "bentley"
    case Buick = "buick"
    case Cadillac = "cadillac"
    case Chevrolet = "chevrolet"
    case Chrysler = "chrysler"
    case Daewoo = "daewoo"
    case Dodge = "dodge"
    case Eagle = "eagle"
    case Fiat = "fiat"
    case Ferrari = "ferrari"
    case Fisker = "fisker"
    case Ford = "ford"
    case GMC = "gmc"
    case Geo = "geo"
    case Hummer = "hummer"
    case Honda = "honda"
    case Hyundai = "hyundai"
    case Infiniti = "infiniti"
    case Isuzu = "isuzu"
    case Jaguar = "jaguar"
    case Jeep = "jeep"
    case Kia = "kia"
    case Lamborghini = "lamborghini"
    case LandRover = "landrover"
    case Lexus = "lexus"
    case Lincoln = "lincoln"
    case Lotus = "lotus"
    case Maserati = "maserati"
    case Mini = "mini"
    case Maybach = "maybach"
    case Mazda = "mazda"
    case MercedesBenz = "mercedesbenz"
    case Mercury = "mercury"
    case Mitsubishi = "mitsubishi"
    case Nissan = "nissan"
    case Oldsmobile = "oldsmobile"
    case Panoz = "panoz"
    case Plymouth = "plymouth"
    case Pontiac = "pontiac"
    case Porsche = "porsche"
    case Ram = "ram"
    case RollsRoyce = "rollsroyce"
    case Saab = "saab"
    case Saturn = "saturn"
    case Scion = "scion"
    case Smart = "smart"
    case Spyker = "spyker"
    case Subaru = "subaru"
    case Suzuki = "suzuki"
    case Tesla = "tesla"
    case Toyota = "toyota"
    case Volkswagen = "volkswagen"
    case Volvo = "volvo"
    
    func toImage() -> (UIImage?) {
        var imageName: String
        
        switch self {
        case .AMGeneral:
            imageName = "amgeneral"
        case .Acura:
            imageName = "acura"
        case .AlfaRomeo:
            imageName = "alfaromeo"
        case .AstonMartin:
            imageName = "astonmartin"
        case .Audi:
            imageName = "audi"
        case .BMW:
            imageName = "bmw"
        case .Bentley:
            imageName = "bentley"
        case .Buick:
            imageName = "buick"
        case .Cadillac:
            imageName = "cadillac"
        case .Chevrolet:
            imageName = "chevrolet"
        case .Chrysler:
            imageName = "chrysler"
        case .Daewoo:
            imageName = "daewoo"
        case .Dodge:
            imageName = "dodge"
        case .Eagle:
            imageName = "eagle"
        case .Fiat:
            imageName = "fiat"
        case .Ferrari:
            imageName = "ferrari"
        case .Fisker:
            imageName = "fisker"
        case .Ford:
            imageName = "ford"
        case .GMC:
            imageName = "gmc"
        case .Geo:
            imageName = "geo"
        case .Hummer:
            imageName = "hummer"
        case .Honda:
            imageName = "honda"
        case .Hyundai:
            imageName = "hyundai"
        case .Infiniti:
            imageName = "infiniti"
        case .Isuzu:
            imageName = "isuzu"
        case .Jaguar:
            imageName = "jaguar"
        case .Jeep:
            imageName = "jeep"
        case .Kia:
            imageName = "kia"
        case .Lamborghini:
            imageName = "lamborghini"
        case .LandRover:
            imageName = "landrover"
        case .Lexus:
            imageName = "lexus"
        case .Lincoln:
            imageName = "lincoln"
        case .Lotus:
            imageName = "lotus"
        case .Maserati:
            imageName = "maserati"
        case .Mini:
            imageName = "mini"
        case .Maybach:
            imageName = "maybach"
        case .Mazda:
            imageName = "mazda"
        case .MercedesBenz:
            imageName = "mercedesbenz"
        case .Mercury:
            imageName = "mercury"
        case .Mitsubishi:
            imageName = "mitsubishi"
        case .Nissan:
            imageName = "nissan"
        case .Oldsmobile:
            imageName = "oldsmobile"
        case .Panoz:
            imageName = "panoz"
        case .Plymouth:
            imageName = "plymouth"
        case .Pontiac:
            imageName = "pontiac"
        case .Porsche:
            imageName = "porsche"
        case .Ram:
            imageName = "ram"
        case .RollsRoyce:
            imageName = "rollsroyce"
        case .Saab:
            imageName = "saab"
        case .Saturn:
            imageName = "saturn"
        case .Scion:
            imageName = "scion"
        case .Smart:
            imageName = "smart"
        case .Spyker:
            imageName = "spyker"
        case .Subaru:
            imageName = "subaru"
        case .Suzuki:
            imageName = "suzuki"
        case .Tesla:
            imageName = "tesla"
        case .Toyota:
            imageName = "toyota"
        case .Volkswagen:
            imageName = "volkswagen"
        case .Volvo:
            imageName = "volvo"

        }
        
        let regularIcon = UIImage(named: "\(imageName).png")
        
        return (regularIcon)
    }
}


