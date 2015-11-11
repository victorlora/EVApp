//
//  ViewController.swift
//  Voltage
//
//  Created by Josh Rosenzweig on 11/2/15.
//  Copyright © 2015 EV-APP. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    var parser = NSXMLParser()
    var posts = NSMutableArray()
    var elements = NSMutableDictionary()
    var element = NSString()
    var title1 = NSMutableString()
    var date = NSMutableString()
    
    @IBOutlet weak var carViewer: UITableView!
    @IBOutlet weak var carTaskLabel: UILabel!
    
    private let carFinderAPIKey = "6m8ettta5byepu43rkhsc79j"

    let textCellIdentifier = "carChoice"
    let manufacturers = ["AM General", "Acura", "Alfa Romeo", "Aston Martin", "Audi", "BMW", "Bentley", "Buick","Cadillac", "Chevrolet", "Chrysler", "Daewoo", "Dodge", "Eagle", "Fiat", "Ferrari", "Fisker", "Ford", "GMC", "Geo", "Hummer", "Honda", "Hyundai", "Infiniti", "Isuzu", "Jaguar", "Jeep", "Kia", "Lamborghini", "Land Rover", "Lexus", "Lincoln", "Lotus","Maserati", "Mini", "Maybach", "Mazda", "Mercedes Benz", "Mercury", "Mitsubishi", "Nissan", "Oldsmobile", "Panoz", "Plymouth", "Pontiac", "Porsche", "Ram", "Rolls Royce", "Saab", "Saturn", "Scion", "Spyker", "Subaru", "Suzuki", "Tesla", "Toyota", "Volkswagen", "Volvo", "Smart",  ]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        carViewer.delegate = self
        carViewer.dataSource = self
        carTaskLabel.text = "Select Car Make"
        configureView()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func configureView() {
        // Set custom height for table view row
        carViewer.rowHeight = 36
        carViewer.backgroundColor = UIColor.blackColor()
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
  
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return manufacturers.count
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let cell = carViewer.dequeueReusableCellWithIdentifier(textCellIdentifier, forIndexPath: indexPath) as UITableViewCell

        let row = indexPath.row
        
        cell.textLabel?.text = manufacturers[row]
        return cell
        
    }
    
    func tableView(carViewer: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        carViewer.deselectRowAtIndexPath(indexPath, animated: true)
        
        let row = indexPath.row
        print(manufacturers[row])
    }
    // Swift: Using external databases and API's part 2: The App
}

