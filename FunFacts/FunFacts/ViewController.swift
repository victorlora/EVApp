//
//  ViewController.swift
//  FunFacts
//
//  Created by Josh Rosenzweig on 8/3/15.
//  Copyright (c) 2015 Volt. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var funFactLabel: UILabel!
    @IBOutlet weak var FunFactButton: UIButton!
    
    let factBook = FactBook()
    let colorWheel = ColorWheel()
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        funFactLabel.text = factBook.randomFact()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func showFunFact() {
        let randomColor = colorWheel.randomColor()
        view.backgroundColor = randomColor
        FunFactButton.tintColor = randomColor
        funFactLabel.text = factBook.randomFact()
    }

}

